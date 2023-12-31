/**
 * @name S3 Bucket Logging Disabled
 * @description S3 Bucket Logging Disabled
 * @kind problem
 * @problem.severity warning
 * @security-severity 8.0
 * @precision high
 * @id tf/aws/storage-logging-disabled
 * @tags security
 *       terraform
 *       aws
 *       storage
 */

import hcl

from AWS::S3Bucket buckets
where
  // Disable by default
  not exists(buckets.getLogging()) and
  // Only checks buckets that are themselves used for storing logs
  not buckets.getAclValue() = "log-delivery-write"
select buckets, "Logging disabled for: \"" + buckets.getName() + "\""
