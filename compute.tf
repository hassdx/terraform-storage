resource "aws_lb" "main" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.lb_sg.id]
  subnets = [
    data.aws_subnet.public_subnet1.id,
    data.aws_subnet.public_subnet2.id
  ]

  tags = {
    Name = var.alb_name
  }

}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = var.blue_weight
      }

      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = var.green_weight
      }

      stickiness {
        enabled  = false
        duration = 1
      }
    }
  }
}

resource "aws_lb_target_group" "blue" {
  name     = var.blue_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id

  tags = {
    Name        = var.blue_tg_name
    Environment = "blue"
  }
}

resource "aws_lb_target_group" "green" {
  name     = var.green_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id

  tags = {
    Name        = var.green_tg_name
    Environment = "green"
  }
}


resource "aws_launch_template" "blue" {
  name          = var.blue_template_name
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    data.aws_security_group.ssh_sg.id,
    data.aws_security_group.http_sg.id,
  ]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl enable httpd
    systemctl start httpd
    TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
      -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
    INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
      http://169.254.169.254/latest/meta-data/instance-id)
    cat > /var/www/html/index.html <<HTML
    <!DOCTYPE html>
    <html>
      <head><title>Blue</title></head>
      <body>
        <h1> Blue Environment</h1>
        <p>Instance: $INSTANCE_ID</p>
      </body>
    </html>
    HTML
  EOF
  )

}

resource "aws_launch_template" "green" {
  name          = var.green_template_name
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    data.aws_security_group.ssh_sg.id,
    data.aws_security_group.http_sg.id,
  ]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl enable httpd
    systemctl start httpd
    TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
      -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
    INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
      http://169.254.169.254/latest/meta-data/instance-id)
    cat > /var/www/html/index.html <<HTML
    <!DOCTYPE html>
    <html>
      <head><title>Green</title></head>
      <body>
        <h1> Green Environment</h1>
        <p>Instance: $INSTANCE_ID</p>
      </body>
    </html>
    HTML
  EOF
  )
}

resource "aws_autoscaling_group" "blue" {
  name                = var.blue_asg_name
  min_size            = 1
  max_size            = 2
  desired_capacity    = 2
  vpc_zone_identifier = [data.aws_subnet.public_subnet1.id, data.aws_subnet.public_subnet2.id]
  target_group_arns   = [aws_lb_target_group.blue.arn]


  launch_template {
    id      = aws_launch_template.blue.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.blue_asg_name
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "green" {
  name                = var.green_asg_name
  min_size            = 1
  max_size            = 2
  desired_capacity    = 2
  vpc_zone_identifier = [data.aws_subnet.public_subnet1.id, data.aws_subnet.public_subnet2.id]
  target_group_arns   = [aws_lb_target_group.green.arn]


  launch_template {
    id      = aws_launch_template.green.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.green_asg_name
    propagate_at_launch = true
  }

}