/**
 * @name ECS task definitions should have a logging configuration
 * @kind problem
 * @problem.severity warning
 * @id iac/ecs/log-configuration
 * @tags security
 *       aws/ecs/9
 *       NIST/800-53/AC-4(26)
 *       NIST/800-53/AU-10
 *       NIST/800-53/AU-12
 *       NIST/800-53/AU-2
 *       NIST/800-53/AU-3
 *       NIST/800-53/AU-6(3)
 *       NIST/800-53/AU-6(4)
 *       NIST/800-53/CA-7
 *       NIST/800-53/SC-7(9)
 *       NIST/800-53/SI-7(8)
 */

import iac

from CloudFormation::ContainerDefinition cd
where not exists(cd.getLogConfiguration())
select cd, "ContainerDefinitions must have a log configuration"

