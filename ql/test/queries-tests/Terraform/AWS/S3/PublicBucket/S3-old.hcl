resource "aws_s3_bucket" "data1" {
  bucket = "${local.resource_prefix.value}-data"
}

resource "aws_s3_bucket" "data2" {
  bucket = "${local.resource_prefix.value}-data-science"
  // old attribute block
  acl = "public-read"
}

resource "aws_s3_bucket" "data3" {
  bucket = "${local.resource_prefix.value}-data-science"
  // old attribute block
  acl = "private"
}
