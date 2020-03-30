output "service_endpoint" {
  value = aws_lb.app.dns_name
}
