/**
 * @name Cluster Pod Security Policy
 * @description Cluster Pod Security Policy
 * @kind problem
 * @problem.severity warning
 * @security-severity 5.0
 * @precision high
 * @id hcl/gcp/cluster-pod-security-policy
 * @tags security
 */

import hcl

from Resource resource
where
  resource.getResourceType() = "google_container_cluster" and
  not resource.hasAttribute("pod_security_policy_config")
// or
// attr = resource.getAttribute("pod_security_policy_config")
// TODO check if set to true
select resource, "No Pod Security Policy Defined"
