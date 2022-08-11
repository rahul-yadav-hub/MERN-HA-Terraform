
data "aws_route53_zone" "selected" {
  count = var.count_value ? 1 : 0
  name         = var.hosted_zone_name
  private_zone = false
}

resource "aws_route53_record" "Arecord" {
  count = var.count_value ? 1 : 0
  zone_id = data.aws_route53_zone.selected[0].zone_id # automatically gets zone id
  name    = var.subdomain_name
  type    = var.record_type
  alias {
    name                   = var.record
    zone_id                = var.resource_zone_id
    evaluate_target_health = true
  }
}