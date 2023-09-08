/**
 * @name S3 Bucket Logging Disabled
 * @description S3 Bucket Logging Disabled
 * @kind problem
 * @problem.severity warning
 * @security-severity 8.0
 * @precision high
 * @id hcl/aws/s3-logging-disabled
 * @tags security
 */

import hcl

from Resource r
where
  r.getResourceType() = "aws_s3_bucket" and
  // Disable by default
  not r.hasAttribute("logging")
// target_bucket = "target-bucket"
select r, "Logging disabled for: \"" + r.getName() + "\""
