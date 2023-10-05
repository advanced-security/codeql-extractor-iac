/**
 * @name Unencrytped S3 Bucket
 * @description Unencrytped S3 Bucket
 * @kind problem
 * @problem.severity warning
 * @security-severity 6.0
 * @precision high
 * @id tf/aws/storage-unencrypted
 * @tags security
 *       terraform
 *       aws
 *       storage
 */

import hcl

from AWS::S3Bucket buckets
where
  // Default is unencrypted
  not exists(buckets.getEncryptionConfiguration())
select buckets, "S3 Bucket Unencrypted: \"" + buckets.getName() + "\""
