resource "aws_lb" "frontend_lb" {
  name               = "frontend-lb"
  internal           = false
  subnets            = aws_subnet.public[*].id
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]

  tags = {
    Name = "frontend-lb"
  }
}

resource "aws_lb" "backend_lb" {
  name               = "backend-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = aws_subnet.public[*].id

  tags = {
    Name = "backend-lb"
  }
}

resource "aws_lb" "metabase_lb" {
  name               = "metabase-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = aws_subnet.public[*].id

  tags = {
    Name = "metabase-lb"
  }
}

# ** TARGET GROUPS AND THEIR INSTANCES **

# Define target groups for each NLB

resource "aws_lb_target_group" "frontend_target_group" {
  name     = "frontend-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  # Additional attributes such as health checks can be configured here
}

resource "aws_lb_target_group" "backend_target_group" {
  name     = "backend-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  # Additional attributes such as health checks can be configured here
}

resource "aws_lb_target_group" "metabase_target_group" {
  name     = "metabase-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  # Additional attributes such as health checks can be configured here
}

# Register EC2 instances with their respective target groups

resource "aws_lb_target_group_attachment" "frontend_attachment" {
  target_group_arn = aws_lb_target_group.frontend_target_group.arn
  target_id        = aws_instance.ubuntu_frontend_instance.id
}

resource "aws_lb_target_group_attachment" "backend_attachment" {
  target_group_arn = aws_lb_target_group.backend_target_group.arn
  target_id        = aws_instance.ubuntu_backend_instance.id
}

resource "aws_lb_target_group_attachment" "metabase_attachment" {
  target_group_arn = aws_lb_target_group.metabase_target_group.arn
  target_id        = aws_instance.ubuntu_metabase_instance.id
}

# ** Listeners **

# Define listeners for each NLB

resource "aws_lb_listener" "frontend_listener" {
  load_balancer_arn = aws_lb.frontend_lb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn = aws_acm_certificate_validation.frontend-cert.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_target_group.arn
  }
}

resource "aws_lb_listener" "backend_listener" {
  load_balancer_arn = aws_lb.backend_lb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn = aws_acm_certificate_validation.backend-cert.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_target_group.arn
  }
}

resource "aws_lb_listener" "metabase_listener" {
  load_balancer_arn = aws_lb.metabase_lb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn = aws_acm_certificate_validation.metabase-cert.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.metabase_target_group.arn
  }
}