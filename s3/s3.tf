variable "bucket_name" {}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "my_bucket" {
  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}

output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}
