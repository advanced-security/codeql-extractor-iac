/**
 * @name Action Wildcard
 * @kind problem
 * @problem.severity warning
 * @id iac/iam/action-wildcard
 * @tag security
 */

import iac

from CloudFormation::IAMStatement statement 
where  exists(CloudFormation::IAMRole role 
    | statement = role.getPolicy() 
    | statement.getAction().toString() = ["\"*\"", "'*'", "*"]
    and statement.getEffect().toString() = ["Allow", "\"Allow\""])
select statement.getAction(), "IAM role is using wildcard action"
