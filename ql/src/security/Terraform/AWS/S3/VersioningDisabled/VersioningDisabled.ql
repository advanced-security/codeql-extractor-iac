/**
 * @name S3 Bucket Versioning Disabled
 * @description S3 Bucket Versioning Disabled
 * @kind problem
 * @problem.severity warning
 * @security-severity 8.0
 * @precision high
 * @id hcl/aws/s3-versioning-disabled
 * @tags security
 *       aws
 */

import hcl

from AWS::S3Bucket buckets
where
  // Disable by default
  not exists(buckets.getVersioning())
  or
  // If disabled
  buckets.getVersioningValue() = false
select buckets, "Versioning disabled for: \"" + buckets.getName() + "\""
