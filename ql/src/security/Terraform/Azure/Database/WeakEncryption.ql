/**
 * @name Azure Service TLS/SSL Weak Encryption
 * @description Azure Service TLS/SSL Weak Encryption
 * @kind problem
 * @problem.severity error
 * @security-severity 4.0
 * @precision high
 * @id tf/azure/database-weak-encryption
 * @tags security
 *       terraform
 *       azure
 *       database
 */

import hcl

from Resource resource, Expr attr
where
  resource.getResourceType() = ["azurerm_mysql_server", "azurerm_postgresql_server"] and
  attr = resource.getAttribute("ssl_minimal_tls_version_enforced") and
  attr.(StringLiteral).getValue() = ["TLS1_0", "TLS1_1"]
select attr, "Weak Encryption"
