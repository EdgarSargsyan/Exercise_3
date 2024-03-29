output "s3_bucket_arn" {
  value = aws_s3_bucket.ess3bucket.arn
}

# Output the DNS name of the load balancer
output "load_balancer_dns_name" {
  value = aws_lb.my_alb.dns_name
}
