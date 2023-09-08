/**
 * @name GCP ABAC Permissions enabled
 * @description GCP ABAC Permissions enabled
 * @kind problem
 * @problem.severity warning
 * @security-severity 8.0
 * @precision high
 * @id hcl/gcp/abac-enabled
 * @tags security
 */

import hcl

from Resource resource, Expr attr
where
  resource.getResourceType() = "google_container_cluster" and
  attr = resource.getAttribute("enable_legacy_abac")
// TODO check if set to true
select attr, "ABAC Enabled"
