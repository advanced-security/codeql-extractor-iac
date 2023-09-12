/**
 * @name Azure Database Geo Backup Unset or Disabled
 * @description Azure Database Geo Backup Unset or Disabled
 * @kind problem
 * @problem.severity info
 * @security-severity 2.0
 * @precision high
 * @id hcl/azure/ssl-disabled
 * @tags security
 *       azure
 */

import hcl

from Azure::Database resource, Expr sink
where
  not resource.hasAttribute("infrastructure_encryption_enabled") and sink = resource
  or
  resource.getInfrastructureEncryptionEnabled() = false and
  sink = resource.getAttribute("infrastructure_encryption_enabled")
select sink, "Geo Backup Disabled"
