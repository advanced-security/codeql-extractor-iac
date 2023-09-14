/**
 * @name Public S3 Bucket
 * @description Public S3 Bucket
 * @kind problem
 * @problem.severity error
 * @security-severity 10.0
 * @precision high
 * @id hcl/aws/public-s3-bucket
 * @tags security
 */

import hcl

from AWS::S3Bucket buckets
where
  // Default is public
  not exists(buckets.getAcl())
  or
  // Check for public-read
  buckets.getAclValue() = "public-read"
select buckets, "Public S3 Bucket resource"
