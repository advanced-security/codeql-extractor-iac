/**
 * @name Lambda Concurrency Limit
 * @kind problem
 * @problem.severity warning
 * @id iac/lambda/reserved-concurrency-limit
 * @tag security
 */

import iac

from CloudFormation::LambdaFunction lambda
where not exists(lambda.getProperties().getProperty("ReservedConcurrentExecutions"))
select lambda, "Lambda functions should specify a reserved concurrency limit."
