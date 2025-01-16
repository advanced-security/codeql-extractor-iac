/**
 * @name Lambda Supported Runtime
 * @kind problem
 * @problem.severity warning
 * @id iac/lambda/reserved-concurrency-limit
 * @tag security
 */

import iac

from CloudFormation::LambdaFunction lambda
where lambda.getRuntime() = ["dotnet8", "dotnet6", "java21", "java17", "java11", "java8.al2", "nodejs22.x", "nodejs20.x", "nodejs18.x", "python3.13", "python3.12", "python3.11", "python3.10", "python3.9", "python3.8", "ruby3.3", "ruby3.2"]
select lambda, "Lambda functions must specify a supported Runtime."
