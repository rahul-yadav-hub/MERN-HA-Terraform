resource "aws_acm_certificate" "cert" {
  count = var.count_value ? 1 : 0
  domain_name       = var.subdomain_name
  validation_method = "DNS"
  
  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "selected" {
  count = var.count_value ? 1 : 0
  name         = var.hosted_zone_name
  private_zone = false
}


resource "aws_route53_record" "validate" {
  count = var.count_value ? 1 : 0

  name            = tolist(aws_acm_certificate.cert[0].domain_validation_options)[0].resource_record_name
  records         = [ tolist(aws_acm_certificate.cert[0].domain_validation_options)[0].resource_record_value ]
  type            = tolist(aws_acm_certificate.cert[0].domain_validation_options)[0].resource_record_type
  allow_overwrite = true
  ttl             = 60
  zone_id         = data.aws_route53_zone.selected[0].zone_id
}

// waits for validation
resource "aws_acm_certificate_validation" "validate" {
  count = var.count_value ? 1 : 0
  depends_on = [aws_acm_certificate.cert[0]]
  certificate_arn         = aws_acm_certificate.cert[0].arn
  validation_record_fqdns = [for record in aws_route53_record.validate : record.fqdn]
}