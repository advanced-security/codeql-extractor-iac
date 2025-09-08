import hcl

query predicate resource(AWS::AwsResource n) { any() }

query predicate buckets(AWS::S3Bucket n) { any() }

query predicate bucketsLogging(AWS::S3Bucket n, AWS::S3BucketLogging log) {
  any() and log = n.getLogging()
}

query predicate bucketsAcl(AWS::S3Bucket n, AWS::S3BucketAcl acl) { any() and acl = n.getAcl() }
