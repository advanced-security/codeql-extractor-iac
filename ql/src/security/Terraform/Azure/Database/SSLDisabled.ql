/**
 * @name Azure Service TLS/SSL Disable
 * @description Azure Service TLS/SSL Disable
 * @kind problem
 * @problem.severity error
 * @security-severity 10.0
 * @precision high
 * @id tf/azure/database-tls-disable
 * @tags security
 *       terraform
 *       azure
 *       database
 */

import hcl

from Azure::Database database
where database.getSslEnforcementEnabled() = false
select database.getAttribute("ssl_enforcement_enabled"), "TLS/SSL Disabled"
