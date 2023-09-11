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
  private class GcpResource extends Resource, Block {
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

  class PodSecurityPolicyConfig extends GcpResource {
    boolean getEnabled() { result = this.getAttribute("enabled").(BooleanLiteral).getBool() }
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
}
