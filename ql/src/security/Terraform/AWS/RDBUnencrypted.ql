/**
 * @name RDS Database Unencrypted
 * @description RDS Database Unencrypted
 * @kind problem
 * @problem.severity warning
 * @security-severity 8.0
 * @precision high
 * @id tf/aws/rds-database-unencrytped
 * @tags security
 */

import hcl

from Resource r
where
  r.getResourceType() = "aws_db_instance" and
  not r.hasAttribute("storage_encrypted")
// TODO: check if set to true
select r, "S3 Bucket Unencrypted: \"" + r.getName() + "\""
