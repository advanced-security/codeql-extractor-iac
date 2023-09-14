resource "aws_s3_bucket" "data" {
  bucket = "${local.resource_prefix.value}-data"
}

resource "aws_s3_bucket" "data_science" {
  bucket = "${local.resource_prefix.value}-data-science"
  // old attribute block
  logging {
    target_bucket = aws_s3_bucket.logs.id
  }
}
