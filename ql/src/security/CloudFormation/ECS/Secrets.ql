/**
 * @name Secrets should not be passed as container environment variables
 * @kind problem
 * @problem.severity warning
 * @id iac/ecs/secrets
 * @tags security
 *       aws/ecs/8
 *       NIST/800-53/AC-2(1)
 *       NIST/800-53/AC-3
 *       NIST/800-53/AC-3(15)
 *       NIST/800-53/AC-3(7)
 *       NIST/800-53/AC-5
 *       NIST/800-53/AC-6
 */

import iac

from CloudFormation::ContainerDefinition cd
//where cd.getSecrets().getAChild().getAChild().toString() = ["'AWS_ACCESS_KEY_ID'", "'AWS_SECRET_ACCESS_KEY'", "'ECS_ENGINE_AUTH_DATA'"]
select cd.getSecrets(), "Containers must not pass secret thorugh environment variables"
