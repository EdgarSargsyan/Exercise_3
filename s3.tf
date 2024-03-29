resource "aws_s3_bucket" "ess3bucket" {
bucket = "ess3bucket"


tags = {
Name = "asbucket Newest S3 Bucket"
}
}