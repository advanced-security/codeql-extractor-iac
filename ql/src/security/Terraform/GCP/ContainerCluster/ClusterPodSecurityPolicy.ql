/**
 * @name Cluster Pod Security Policy (legacy)
 * @description Cluster Pod Security Policy (legacy)
 * @kind problem
 * @problem.severity warning
 * @security-severity 5.0
 * @precision high
 * @id tf/gcp/cluster-pod-security-policy
 * @tags security
 */

import hcl

from GCP::ContainerCluster resource, GCP::PodSecurityPolicyConfig pspc
where
  pspc = resource.getPodSecurityPolicyConfig() and
  pspc.getEnabled() = "false"
select resource, "No Pod Security Policy Defined"
