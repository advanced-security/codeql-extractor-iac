/**
 * @name EKS Cluster Publically Accessible
 * @description Ensure that EKS Clusters are not publically accessible
 * @kind problem
 * @problem.severity error
 * @security-severity 9.0
 * @precision high
 * @id hcl/aws/eks-public-cluster
 * @tags security
 *       aws
 */

import hcl

from AWS::EKSCluster cluster
where
  cluster.getEndpointPublicAccess() = true and
  not exists(cluster.getPublicAccessCidrs())
select cluster.getAttribute("vpc_config"), "EKS Cluster Publically Accessible"