/**
 * @name PublicIPTaskSet
 * @kind problem
 * @problem.severity warning
 * @id iac/ecs/assign-publicip-taskset
 * @tags security
 *       cloudformation
 *       aws/ecs/16
 *       PCI-DSS/4.0.1
 *       PCI-DSS/1.4.4
 */

import iac

from CloudFormation::ECSTaskSet ts
where not ts.getAssignPublicIp().toString() = ["'DISABLED'","DISABLED"]
select ts.getNetworkConfiguration(), "AssignPublicIp must be \"DISABLED\" for ECS tasks"
