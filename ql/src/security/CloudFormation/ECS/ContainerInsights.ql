/**
 * @name ECS clusters should use Container Insights
 * @kind problem
 * @problem.severity warning
 * @id iac/ecs/container-insights
 * @tags security
 *       aws/ecs/12
 *       NIST/800-53/AU-6(3)
 *       NIST/800-53/AU-6(4)
 *       NIST/800-53/CA-7
 *       NIST/800-53/SI-2
 */

import iac

from CloudFormation::ECSCluster cluster
where not cluster.getContainerInsights().toString() = "'enabled'"
select cluster, "ECS Cluster should have cluster settings enabled"