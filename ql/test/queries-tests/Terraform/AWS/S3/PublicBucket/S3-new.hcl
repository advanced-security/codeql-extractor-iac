resource "aws_s3_bucket" "example1" {
  bucket = "my-tf-example1-bucket"
}

resource "aws_s3_bucket_acl" "example1" {
  bucket = aws_s3_bucket.example1.id
  acl    = "private"
}


resource "aws_s3_bucket" "example2" {
  bucket = "my-tf-example2-bucket"
}


resource "aws_s3_bucket_acl" "example2" {
  bucket = aws_s3_bucket.example2.id
  acl    = "public-read"
}
