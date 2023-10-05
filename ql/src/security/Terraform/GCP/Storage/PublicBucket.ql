/**
 * @name Public Storage Bucket
 * @description Public Storage Bucket
 * @kind problem
 * @problem.severity error
 * @security-severity 10.0
 * @precision high
 * @id tf/gcp/storage-publicly-accessible
 * @tags security
 *       terraform
 *       gcp
 *       storage
 */

import hcl

from GCP::StorageBucket bucket, GCP::StorageBucketAccessControl acl
where
  acl.getBucket() = bucket and
  acl.getEntity() = "allUsers"
select bucket, "Public Storage Bucket."
