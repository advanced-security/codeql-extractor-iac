import hcl

query predicate gcp(GCP::GcpResource r) { any() }

query predicate storage(GCP::StorageBucket b) { any() }

query predicate accessControl(GCP::StorageBucketAccessControl r) { any() }

query predicate storageAccess(GCP::StorageBucket b, GCP::StorageBucketAccessControl r) {
  any() and b.getAccessControl() = r
}
