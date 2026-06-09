region                   = "us-east-1"
project_id               = "cmtr-3v98t79h"
vpc_name                 = "cmtr-3v98t79h-vpc"
public_subnet1_name      = "cmtr-3v98t79h-public-subnet1"
public_subnet2_name      = "cmtr-3v98t79h-public-subnet2"
security_group_ssh_name  = "cmtr-3v98t79h-sg-ssh"
security_group_lb_name   = "cmtr-3v98t79h-sg-lb"
security_group_http_name = "cmtr-3v98t79h-sg-http"
instance_type            = "t2.micro"
blue_weight              = 100
green_weight             = 0

alb_name = "cmtr-3v98t79h-lb"

blue_tg_name  = "cmtr-3v98t79h-blue-tg"
green_tg_name = "cmtr-3v98t79h-green-tg"

blue_template_name  = "cmtr-3v98t79h-blue-template"
green_template_name = "cmtr-3v98t79h-green-template"

blue_asg_name  = "cmtr-3v98t79h-blue-asg"
green_asg_name = "cmtr-3v98t79h-green-asg"




