private import iac

query predicate cloudformation(CloudFormation::Document n) { any() }

query predicate resources(CloudFormation::Resource n) { any() }

query predicate resourceProperties(CloudFormation::ResourceProperties n) { any() }

query predicate s3(CloudFormation::S3Bucket n) { any() }

query predicate s3Policy(CloudFormation::S3Bucket n, CloudFormation::S3BucketPolicy p) {
  p = n.getBucketPolicy()
}
