/**
 * @name ECS containers should run as non-privileged
 * @kind problem
 * @problem.severity warning
 * @id iac/ecs/non-priv
 * @tags security
 *       aws/ecs/4
 *       NIST/800-53/AC-2(1)
 *       NIST/800-53/AC-3
 *       NIST/800-53/AC-3(15)
 *       NIST/800-53/AC-3(7)
 *       NIST/800-53/AC-5
 *       NIST/800-53/AC-6
 */

import iac

from CloudFormation::ContainerDefinition cd
where not cd.getPrivileged() = "false"
select cd, "ContainerDefinitions must be explictly configured privileged mode to false"
