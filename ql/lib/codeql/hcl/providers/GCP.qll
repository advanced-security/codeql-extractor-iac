private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants

/**
 * Google Cloud Platform (GCP) module.
 */
module GCP {
  /**
   * Google Cloud Platform (GCP) resource.
   */
  class GcpResource extends Resource, Block {
    GcpResource() { this.getResourceType().regexpMatch("^google.*") }
  }

  class ComputeZones extends GcpResource {
    ComputeZones() { this.getResourceType() = "google_compute_zones" }

    Expr getProject() { result = this.getAttribute("project") }
  }

  /**
   * Google Cloud Platform (GCP) resource.
   *
   * https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
   */
  class ContainerCluster extends GcpResource {
    ContainerCluster() { this.getResourceType() = "google_container_cluster" }

    /**
     * Get the Legacy Role-Based Access Control (RBAC) setting.
     */
    boolean getRbac() {
      result = this.getAttribute("enable_legacy_abac").(BooleanLiteral).getBool()
    }

    /**
     */
    boolean getRemoveDefaultNodePool() {
      result = this.getAttribute("remove_default_node_pool").(BooleanLiteral).getBool()
    }

    Expr getMonitoringService() { result = this.getAttribute("monitoring_service") }

    Expr getLoggingService() { result = this.getAttribute("logging_service") }

    Expr getAuthorizedNetworks() { result = this.getAttribute("master_authorized_networks_config") }

    PodSecurityPolicyConfig getPodSecurityPolicyConfig() {
      result = this.getAttribute("pod_security_policy_config")
    }
  }

  class PodSecurityPolicyConfig extends Block {
    private ContainerCluster cluster;

    PodSecurityPolicyConfig() { cluster.getAttribute("pod_security_policy_config") = this }

    string getEnabled() { result = this.getAttribute("enabled").(StringLiteral).getValue() }
  }

  class ContainerNodePool extends GcpResource {
    private ContainerCluster cluster;

    ContainerNodePool() { this.getResourceType() = "google_container_node_pool" }

    /**
     * Get the cluster that this node pool belongs to.
     */
    ContainerCluster getCluster() { none() }

    Expr getNodeConfig() { result = this.getAttribute("node_config") }
  }

  /**
   * Google Cloud Platform (GCP) Storage Bucket resource.
   */
  class StorageBucket extends GcpResource {
    StorageBucket() { this.getResourceType() = "google_storage_bucket" }

    StorageBucketAccessControl getAccessControl() {
      exists(StorageBucketAccessControl sbac | sbac.getBucket() = this | result = sbac)
    }
  }

  /**
   * Google Cloud Platform (GCP) Storage Bucket Access Control resource.
   */
  class StorageBucketAccessControl extends GcpResource {
    StorageBucketAccessControl() { this.getResourceType() = "google_storage_bucket_access_control" }

    StorageBucket getBucket() { result = this.getAttribute("bucket").getParent() }

    /**
     * Get the role of the access control.
     */
    string getRole() { result = this.getAttribute("role").(StringLiteral).getValue() }

    /**
     * Get the entity of the access control.
     */
    string getEntity() { result = this.getAttribute("entity").(StringLiteral).getValue() }
  }
}
