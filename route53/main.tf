resource "aws_route53_zone" "dns-record" {
  name = var.dns-record
  comment = "${var.dns-record} public zone"
  provider = aws
}
resource "aws_route53_record" "dns-record" {
  zone_id = 
  name    = ""
  type    = "A"
  ttl     = "300"
  records = [""]
}
