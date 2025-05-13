resource "aws_security_group" "ec2_sg" {
  name        = "${var.name_prefix}-ec2-sg"
  description = "Allow inbound HTTP from ALB only"
  vpc_id = var.vpc_id

  

ingress {
    description     = "Allow HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-ec2-sg"
  }
}

resource "aws_launch_template" "web" {
    name_prefix = "${var.name_prefix}-web-"
    image_id = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
vpc_security_group_ids = [aws_security_group.ec2_sg.id]
user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd
echo "Hello from $(hostname)" > /var/www/html/index.html
EOF
)

tags = {
  Name = "${var.name_prefix}-launch-template"
}

lifecycle {
  create_before_destroy = true
}
}

resource "aws_autoscaling_group" "bar" {

    name_prefix         = "${var.name_prefix}-asg"
    vpc_zone_identifier = var.subnet_ids
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size
  target_group_arns   = var.target_group_arns
  health_check_type         = "ELB"
  health_check_grace_period = 300



  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-web"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
