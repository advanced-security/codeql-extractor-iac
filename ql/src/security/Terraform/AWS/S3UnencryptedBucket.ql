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

from Resource r
where
  r.getResourceType() = "aws_s3_bucket" and
  not r.hasAttribute("server_side_encryption_configuration")
select r, "S3 Bucket Unencrypted: \"" + r.getName() + "\""
