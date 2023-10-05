/**
 * @name Azure Database Geo Backup Unset or Disabled
 * @description Azure Database Geo Backup Unset or Disabled
 * @kind problem
 * @problem.severity info
 * @security-severity 2.0
 * @precision low
 * @id terraform/azure/ssl-disabled
 * @tags security
 */

import hcl

from Azure::Database resource, Expr sink
where
  not resource.hasAttribute("geo_redundant_backup_enabled") and sink = resource
  or
  resource.getGeoRedundantBackupEnabled() = false and
  sink = resource.getAttribute("geo_redundant_backup_enabled")
select sink, "Geo Backup Disabled"
