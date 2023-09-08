/**
 * @name Azure Service TLS/SSL Disable
 * @description Azure Service TLS/SSL Disable
 * @kind problem
 * @problem.severity error
 * @security-severity 10.0
 * @precision high
 * @id hcl/azure/ssl-disabled
 * @tags security
 */

import hcl

from Resource resource, Expr attr
where
  resource.getResourceType() = ["azurerm_mysql_server", "azurerm_postgresql_server"] and
  attr = resource.getAttribute("ssl_enforcement_enabled")
// TODO: attr check to make sure its false
select attr, "TLS/SSL Disabled"
