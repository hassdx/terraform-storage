resource "aws_instance" "web" {

  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  subnet_id              = data.aws_subnet.public_subnet.id
  vpc_security_group_ids = [data.aws_security_group.sg.id]

  tags = {
    Project = var.project_id
    Name    = var.instance_name
  }
}
