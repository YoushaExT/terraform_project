resource "aws_route53_record" "frontend" {
  zone_id = "Z1024424D11B7SLAVOWH"
  name    = var.frontend_domain
  type    = "A"
  ttl     = "300"
  records = [aws_instance.ubuntu_frontend_instance.public_ip]
}

resource "aws_route53_record" "backend" {
  zone_id = "Z1024424D11B7SLAVOWH"
  name    = var.backend_domain
  type    = "A"
  ttl     = "300"
  records = [aws_instance.ubuntu_backend_instance.public_ip]
}

resource "aws_route53_record" "metabase" {
  zone_id = "Z1024424D11B7SLAVOWH"
  name    = var.metabase_domain
  type    = "A"
  ttl     = "300"
  records = [aws_instance.ubuntu_metabase_instance.public_ip]
}
