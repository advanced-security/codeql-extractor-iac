/**
 * @name Amazon ECS task definitions should have secure networking modes and user definitions.
 * @kind problem
 * @problem.severity warning
 * @id iac/ecs/networkmode
 * @tags security
 *       experimental
 *       /aws/config/ecs/1
 *       /NIST/800-53/AC-2(1)
 *       /NIST/800-53/AC-3
 *       /NIST/800-53/AC-3(15)
 *       /NIST/800-53/AC-3(7)
 *       /NIST/800-53/AC-5
 *       /NIST/800-53/AC-6
 */

import iac

//Check for NetworkMode to not be host in taskdefinition, this is very much experimental -> Experimental
from CloudFormation::ContainerDefinition cd, CloudFormation::TaskDefinition td
where
  (cd.getUser().toString() = "'root'" or cd.getPrivileged() = "true") and
  td.getNetworkMode().toString() = "'host'"
select td,
  "ContainerDefinitions must not run as root or be privileged when networkmode Host is used"
