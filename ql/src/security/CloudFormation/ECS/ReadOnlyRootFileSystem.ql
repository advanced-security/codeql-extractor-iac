/**
 * @name ECS containers should be limited to read-only access to root filesystems
 * @kind problem
 * @problem.severity warning
 * @id iac/ecs/read-only-root-filesystem
 * @tags security
 *       aws/ecs/5
 *       NIST/800-53/AC-2(1)
 *       NIST/800-53/AC-3
 *       NIST/800-53/AC-3(15)
 *       NIST/800-53/AC-3(7)
 *       NIST/800-53/AC-5
 *       NIST/800-53/AC-6
 */

import iac

from CloudFormation::ContainerDefinition cd
where not cd.getReadOnlyRootFilesystem() = "true"
select cd, "Containers must have explictly only read only root filesystem"
