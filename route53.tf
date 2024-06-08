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

# Certificate for SSL

resource "aws_acm_certificate" "frontend-cert" {
  domain_name       = var.frontend_domain
  validation_method = "DNS"
}

resource "aws_route53_record" "frontend-cert" {
  for_each = {
    for dvo in aws_acm_certificate.frontend-cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = "Z1024424D11B7SLAVOWH"
}

resource "aws_acm_certificate_validation" "frontend-cert" {
  certificate_arn         = aws_acm_certificate.frontend-cert.arn
  validation_record_fqdns = [for record in aws_route53_record.frontend-cert : record.fqdn]
}

resource "aws_acm_certificate" "backend-cert" {
  domain_name       = var.backend_domain
  validation_method = "DNS"
}

resource "aws_route53_record" "backend-cert" {
  for_each = {
    for dvo in aws_acm_certificate.backend-cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = "Z1024424D11B7SLAVOWH"
}

resource "aws_acm_certificate_validation" "backend-cert" {
  certificate_arn         = aws_acm_certificate.backend-cert.arn
  validation_record_fqdns = [for record in aws_route53_record.backend-cert : record.fqdn]
}

resource "aws_acm_certificate" "metabase-cert" {
  domain_name       = var.metabase_domain
  validation_method = "DNS"
}

resource "aws_route53_record" "metabase-cert" {
  for_each = {
    for dvo in aws_acm_certificate.metabase-cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = "Z1024424D11B7SLAVOWH"
}

resource "aws_acm_certificate_validation" "metabase-cert" {
  certificate_arn         = aws_acm_certificate.metabase-cert.arn
  validation_record_fqdns = [for record in aws_route53_record.metabase-cert : record.fqdn]
}