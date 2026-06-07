resource "aws_launch_template" "my_template" {
  name          = var.template_name
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    delete_on_termination = true

    security_groups = [
      data.aws_security_group.ec2_sg.id,
      data.aws_security_group.http_sg.id
    ]
  }

  iam_instance_profile {
    name = var.instance_profile_name
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  user_data = base64encode(<<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y httpd jq
                sudo systemctl start httpd
                sudo systemctl enable httpd

                TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
                -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
                INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
                http://169.254.169.254/latest/meta-data/instance-id)
                PRIVATE_IP=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
                http://169.254.169.254/latest/meta-data/local-ipv4)
      
                echo "This message was generated on instance $INSTANCE_ID with the following IP: $PRIVATE_IP" > /var/www/html/index.html
              EOF  
  )

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}



resource "aws_autoscaling_group" "asg" {
  name             = var.asg_name
  min_size         = var.asg_min_size
  max_size         = var.asg_max_size
  desired_capacity = var.asg_desired_capacity

  launch_template {
    id      = aws_launch_template.my_template.id
    version = "$Latest"
  }

  vpc_zone_identifier = data.aws_subnets.public_subnet.ids

  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns
    ]
  }

}



resource "aws_lb" "lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.lb_sg.id]
  subnets            = data.aws_subnets.public_subnet.ids

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}




resource "aws_lb_target_group" "tg" {
  name     = var.tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}



resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn    = aws_lb_target_group.tg.arn
}


  