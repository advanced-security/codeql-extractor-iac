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

from Resource r
where
  r.getResourceType() = "aws_s3_bucket" and
  (
    // Default is public
    not r.hasAttribute("acl")
    or
    // If the ACL is set to "public-read"
    exists(StringLiteral str |
      str = r.getAttribute("acl") and
      str.getValue() = "public-read"
    )
  )
select r, "Public S3 Bucket resource"
