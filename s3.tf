resource "aws_s3_bucket" "es-s3-bucket" {
  bucket = "es-s3-bucket"
  acl    = "private"
}
