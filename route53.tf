
# Create Route 53 record pointing to the load balancer
resource "aws_route53_record" "lb_dns_record" {
  zone_id = "Z10299161M47DBD68JOWT"
  name    = "esargsyan"   
  type    = "CNAME"            
  ttl     = "300"
  records = [aws_lb.my_alb.dns_name]
}

