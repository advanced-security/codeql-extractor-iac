/**
 * @name Alicloud Public Bucket
 * @description Elastic Search Logging Disabled
 * @kind problem
 * @problem.severity error
 * @security-severity 10.0
 * @precision high
 * @id hcl/alicloud/public-bucket
 * @tags security
 */

import hcl

from Resource r
where
  r.getResourceType() = "alicloud_oss_bucket" and
  exists(StringLiteral str |
    str = r.getAttribute("acl") and
    str.getValue() = "public-read-write"
  )
select r, "Public and Writeable"
