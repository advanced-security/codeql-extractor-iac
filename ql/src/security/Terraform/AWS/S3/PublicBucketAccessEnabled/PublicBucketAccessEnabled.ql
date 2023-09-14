/**
 * @name S3 Access Policy Allows Public Buckets
 * @description S3 Access Policy Allows Public Buckets
 * @kind problem
 * @problem.severity warning
 * @security-severity 5.0
 * @precision high
 * @id hcl/aws/s3-public-access-disabled
 * @tags security
 */

import hcl

from Resource r
where
  r.getResourceType() = "aws_s3_bucket_public_access_block" and
  not r.hasAttribute("restrict_public_buckets")
// TODO: check if set to try
select r, "Access Policy"
