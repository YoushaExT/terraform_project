resource "aws_route53_record" "frontend" {
  zone_id = "Z1024424D11B7SLAVOWH"
  name    = var.frontend_domain
  type    = "A"
  alias {
    name                   = aws_lb.frontend_lb.dns_name
    zone_id                = aws_lb.frontend_lb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "backend" {
  zone_id = "Z1024424D11B7SLAVOWH"
  name    = var.backend_domain
  type    = "A"
  alias {
    name                   = aws_lb.backend_lb.dns_name
    zone_id                = aws_lb.backend_lb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "metabase" {
  zone_id = "Z1024424D11B7SLAVOWH"
  name    = var.metabase_domain
  type    = "A"
  alias {
    name                   = aws_lb.metabase_lb.dns_name
    zone_id                = aws_lb.metabase_lb.zone_id
    evaluate_target_health = true
  }
}