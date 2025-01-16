/**
 * @name IAM Has RoleName
 * @kind problem
 * @problem.severity warning
 * @id iam/iam/has-role-name
 * @tag security
 */

import iac

from CloudFormation::IAMRole role
where exists(role.getProperty("RoleName"))
select role, "This IAM role has an expclit role name"
