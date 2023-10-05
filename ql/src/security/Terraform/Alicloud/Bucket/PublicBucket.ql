/**
 * @name Alicloud Public Bucket
 * @description Alicloud Public Bucket
 * @kind problem
 * @problem.severity error
 * @security-severity 10.0
 * @precision high
 * @id terraform/alicloud/storage-publicly-accessible
 * @tags security
 *       terraform
 *       alicloud
 *       storage
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
