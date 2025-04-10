/**
 * @name ECS task sets should not automatically assign public IP addresses
 * @kind problem
 * @problem.severity warning
 * @id iac/ecs/assignpublicip
 * @tags security
 *       aws/ecs/2
 *       NIST/800-53/AC-21
 *       NIST/800-53/AC-3
 *       NIST/800-53/AC-3(7)
 *       NIST/800-53/AC-4
 *       NIST/800-53/AC-4(21)
 *       NIST/800-53/AC-6
 *       NIST/800-53/SC-7
 *       NIST/800-53/SC-7(11)
 *       NIST/800-53/SC-7(16)
 *       NIST/800-53/SC-7(20)
 *       NIST/800-53/SC-7(21)
 *       NIST/800-53/SC-7(3)
 *       NIST/800-53/SC-7(4)
 *       NIST/800-53/SC-7(9)
 *       PCI-DSS/4.0.1
 *       PCI-DSS/1.4.4
 */

import iac

from CloudFormation::ECSNetworkConfiguration ecsnetwork
where not ecsnetwork.getAssignPublicIp().toString() = ["'DISABLED'","DISABLED"]
select ecsnetwork.getAssignPublicIp(), "AssignPublicIp should be \"DISABLED\" for ECS tasks"