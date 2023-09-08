/**
 * @name S3 Bucket Versioning Disabled
 * @description S3 Bucket Versioning Disabled
 * @kind problem
 * @problem.severity warning
 * @security-severity 8.0
 * @precision high
 * @id hcl/aws/s3-versioning-disabled
 * @tags security
 */

import hcl

from Resource resource
where
  exists(Resource aws |
    aws.getResourceType() = "aws_s3_bucket" and
    // Disable by default
    (
      not aws.hasAttribute("versioning") and
      resource = aws
    )
    or
    exists(Block block |
      // versioning {
      //     enabled = false
      // }
      block = aws.getAttribute("versioning") and
      block.getAttribute("enabled").(BooleanLiteral).getBool() = false and
      block = resource
    )
  )
select resource, "Versioning disabled for: \"" + resource.getName() + "\""
