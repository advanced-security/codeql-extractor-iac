/**
 * @name Unencrytped S3 Bucket
 * @description Unencrytped S3 Bucket
 * @kind problem
 * @problem.severity warning
 * @security-severity 8.0
 * @precision high
 * @id hcl/aws/unencrytped-s3-bucket
 * @tags security
 */

import hcl

from AWS::S3Bucket buckets
where
  // Default is unencrypted
  not exists(buckets.getEncryptionConfiguration())
select buckets, "S3 Bucket Unencrypted: \"" + buckets.getName() + "\""
