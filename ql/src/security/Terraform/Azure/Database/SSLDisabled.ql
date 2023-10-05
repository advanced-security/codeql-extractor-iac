/**
 * @name Azure Service TLS/SSL Disable
 * @description Azure Service TLS/SSL Disable
 * @kind problem
 * @problem.severity error
 * @security-severity 10.0
 * @precision high
 * @id terraform/azure/database-ssl-disabled
 * @tags security
 */

import hcl

from Azure::Database database
where database.getSslEnforcementEnabled() = false
select database.getAttribute("ssl_enforcement_enabled"), "TLS/SSL Disabled"
