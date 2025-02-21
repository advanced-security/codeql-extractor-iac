/**
 * @name ECS task definitions should not share the host's process namespace
 * @kind problem
 * @problem.severity warning
 * @id iac/ecs/pidmode
 * @tags security
 *       aws/ecs/3
 *       NIST/800-53/CA-9(1)
 *       NIST/800-53/CM-2
 */

import iac

from CloudFormation::TaskDefinition td
where not td.getPidMode().toString() = "task"
select td, "PidMode should be \"task\" for ECS tasks"
