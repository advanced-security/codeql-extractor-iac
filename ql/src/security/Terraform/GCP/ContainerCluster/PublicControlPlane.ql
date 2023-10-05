/**
 * @name Cluster Control Plane Publicly Accessible
 * @description Cluster Control Plane Publicly Accessible
 * @kind problem
 * @problem.severity warning
 * @security-severity 5.0
 * @precision high
 * @id tf/gcp/cluster-control-plane-publicly-accessible
 * @tags security
 */

import hcl

from GCP::ContainerCluster resource, Block config, Block cidr_blocks
where
  config = resource.getAuthorizedNetworks() and
  cidr_blocks = config.getAttribute("cidr_blocks") and
  cidr_blocks.getAttribute("cidr_block").(StringLiteral).getValue() = "0.0.0.0/0"
select cidr_blocks, "No Pod Security Policy Defined"
