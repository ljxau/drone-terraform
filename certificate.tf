resource "aws_acm_certificate" "cert" {
  domain_name       = "drone.avnu.io"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
