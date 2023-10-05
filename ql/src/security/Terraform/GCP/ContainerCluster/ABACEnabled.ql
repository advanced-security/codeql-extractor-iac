/**
 * @name GCP ABAC Permissions enabled
 * @description GCP ABAC Permissions enabled
 * @kind problem
 * @problem.severity warning
 * @security-severity 8.0
 * @precision high
 * @id terraform/gcp/abac-enabled
 * @tags security
 */

import hcl

from GCP::ContainerCluster resource, Expr attr
where attr = resource.getAttribute("enable_legacy_abac")
select attr, "ABAC Enabled"
