# Coverage

The `codeql-extractor-iac` covers a number of technologies today but is being continuously improved.

## Coverage Report

[CSV Coverage reports](https://github.com/advanced-security/codeql-extractor-iac/actions/workflows/coverage.yml) are created every release and push into the main branch.

<!-- coverage-start -->
| Suite         | Query ID                                             | Severity |
| ------------- | ---------------------------------------------------- | -------- |
| code-scanning | tf/alicloud/storage-publicly-accessible              | 10.0     |
| code-scanning | tf/azure/database-unencrypted                        | 7.0      |
| code-scanning | tf/azure/database-geo-backup-unset-or-disabled       | 2.0      |
| code-scanning | tf/azure/database-weak-encryption                    | 4.0      |
| code-scanning | tf/azure/database-tls-disable                        | 10.0     |
| code-scanning | tf/azure/security-center-disabled-notifications      | 3.0      |
| code-scanning | tf/azure/vault-weak-key                              | 8.0      |
| code-scanning | tf/azure/storage-publicly-accessible                 | 10.0     |
| code-scanning | tf/azure/storage-unencrypted                         | 6.0      |
| code-scanning | tf/all/hardcoded-passwords                           | 8.0      |
| code-scanning | tf/gcp/abac-enabled                                  | 8.0      |
| code-scanning | tf/gcp/cluster-pod-security-policy                   | 5.0      |
| code-scanning | tf/gcp/cluster-control-plane-publicly-accessible     | 5.0      |
| code-scanning | tf/gcp/storage-publicly-accessible                   | 10.0     |
| code-scanning | tf/aws/storage-publicly-accessible                   | 10.0     |
| code-scanning | tf/aws/storage-versioning-disabled                   | 6.0      |
| code-scanning | tf/aws/storage-unencrypted                           | 6.0      |
| code-scanning | tf/aws/s3-public-access-disabled                     | 5.0      |
| code-scanning | tf/aws/storage-logging-disabled                      | 8.0      |
| code-scanning | tf/aws/elastic-search-disabled-logging               | 6.0      |
| code-scanning | tf/aws/rds-database-unencrytped                      | 8.0      |
| code-scanning | tf/aws/eks-unencrypted-secrets                       | 8.0      |
| code-scanning | tf/aws/eks-public-cluster                            | 9.0      |
| code-scanning | hc/kubernetes/pod-run-as-root                        | 8.0      |
| code-scanning | hc/kubernetes/privileged-pod                         | 9.0      |
| code-scanning | openapi/web/http-allowed                             | 2.0      |
| code-scanning | actions/github/pull-request-target                   | NA       |
| code-scanning | actions/github/workflow-permissions                  | NA       |
| code-scanning | actions/github/unpinned-tag                          | 9.3      |
| code-scanning | containers/docker/latest-images                      | 2.0      |
| code-scanning | bicep/azure/storage-publicly-accessible              | 10.0     |
| code-scanning | bicep/azure/storage-tls-disabled                     | 9.0      |
| code-scanning | cf/aws/storage-publicly-accessible                   | 10.0     |
| code-scanning | iac/ecs/assignpublicip                               | NA       |
| code-scanning | iac/ecs/non-priv                                     | NA       |
| code-scanning | iac/ecs/container-insights                           | NA       |
| code-scanning | iac/ecs/log-configuration                            | NA       |
| code-scanning | iac/ecs/secrets                                      | NA       |
| code-scanning | iac/ecs/assign-publicip-taskset                      | NA       |
| code-scanning | iac/ecs/read-only-root-filesystem                    | NA       |
| code-scanning | iac/ecs/pidmode                                      | NA       |

<!-- coverage-end -->

Download the coverage report zip, extract the CSV file, and view the content.
This will be continuously updated as new queries are added to the extractor.
