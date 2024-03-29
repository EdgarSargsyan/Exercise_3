resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = var.vpc_tf
}

resource "aws_route" "internet_gateway_route" {
  route_table_id         = var.rt_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_internet_gateway.id
}


# Create an ALB
resource "aws_lb" "my_alb" {
  name               = "es-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.alb_sg.id}"]
  subnets            = ["subnet-0233394f5b04f08be", "subnet-0a69719fc06b92cb4"]  
}

# Create a Target Group
resource "aws_lb_target_group" "my_tg" {
  name     = "es-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_tf
}

# Create a Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "es-alb-sg"
  description = "Security group for ALB"
  vpc_id   = var.vpc_tf
  
  # Define your ingress rules
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

# Create a listener for ALB
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }
}


# Attach ALB Target Group to ALB
resource "aws_lb_target_group_attachment" "my_tg_attachment" {
  target_group_arn = aws_lb_target_group.my_tg.arn
  target_id        = aws_s3_bucket.ess3bucket.arn  
  port             = 80
}



