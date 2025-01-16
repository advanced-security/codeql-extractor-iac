/**
 * @name Lambda VPC
 * @kind problem
 * @problem.severity warning
 * @id iac/lambda/vpc
 * @tag security
 */

import iac

from CloudFormation::LambdaFunction lambda
where not exists(lambda.getProperties().getProperty("VpcConfig"))
select lambda, "This Lambda function has no VPC configuration."
