/**
 * @name Public S3 Bucket
 * @description Public S3 Bucket
 * @kind problem
 * @problem.severity error
 * @security-severity 10.0
 * @precision high
 * @id iac/cloudformation/public-s3-bucket
 * @tags security
 *       aws
 *       cloudformation
 */

import iac

from CloudFormation::S3Bucket bucket
where bucket.getAccessControl() = "PublicRead"
select bucket, "Public S3 Bucket resource"
