/**
 * @name EKS Unencrypted Secrets
 * @description Ensure that EKS Clusters use encryption for secrets
 * @kind problem
 * @problem.severity error
 * @security-severity 8.0
 * @precision high
 * @id hcl/aws/eks-unencrypted-secrets
 * @tags security
 *       aws
 */

import hcl

from AWS::EKSCluster cluster
where not exists(cluster.getEncryptionConfig())
select cluster, "EKS Unencrypted Secrets"
