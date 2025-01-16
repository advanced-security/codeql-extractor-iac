/**
 * @name Resource Wildcard
 * @kind problem
 * @problem.severity warning
 * @id iac/iam/resource-wildcard
 * @tag security
 */

import iac

from CloudFormation::IAMStatement statement 
where  exists(CloudFormation::IAMRole role 
    | statement = role.getPolicy() 
    | statement.getResource().toString() = ["\"*\"", "'*'", "*"]
    and statement.getEffect().toString() = ["Allow", "\"Allow\""])
select statement.getResource(), "IAM role is using wildcard Resouce"
