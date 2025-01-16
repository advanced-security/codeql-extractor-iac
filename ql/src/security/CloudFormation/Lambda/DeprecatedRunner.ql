/**
 * @name Deprecated Lambda Runtime
 * @kind problem
 * @problem.severity warning
 * @id iac/lambda/deprecated-runner
 * @tag security
 */

import iac

from CloudFormation::LambdaFunction lambda
where lambda.getRuntime() = "nodejs16.x"
select lambda.getProperties().getProperty("Runtime"), "This Lambda function uses the deprecated Node.js 16.x runtime."
