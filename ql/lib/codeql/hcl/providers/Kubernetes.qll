/**
 * Classes and predicates for analyzing Kubernetes provider resources and configurations in HCL.
 * This module provides specific support for Kubernetes resources, data sources, and provider configurations
 * commonly used in Terraform for managing Kubernetes cluster resources.
 */

private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants

/**
 * Kubernetes provider module containing classes for analyzing Kubernetes-specific HCL configurations.
 *
 * This module provides specialized classes for Kubernetes resources like deployments, services,
 * config maps, and other Kubernetes objects commonly defined in Terraform configurations.
 */
module Kubernetes {
  /**
   * A Kubernetes resource in HCL configuration.
   *
   * Kubernetes resources represent objects that are managed within a Kubernetes cluster,
   * such as deployments, services, pods, config maps, secrets, etc.
   *
   * Example Kubernetes resources:
   * ```
   * resource "kubernetes_deployment" "nginx" {
   *   metadata {
   *     name = "nginx-deployment"
   *   }
   *
   *   spec {
   *     replicas = 3
   *
   *     selector {
   *       match_labels = {
   *         App = "nginx"
   *       }
   *     }
   *   }
   * }
   * ```
   */
  class KubernetesResource extends Resource, Block {
    KubernetesResource() { this.getResourceType().regexpMatch("^kubernetes.*") }
  }

  /**
   * Kubernetes provider.
   */
  class KubernetesProvider extends Provider {
    KubernetesProvider() { this.getName() = "kubernetes" }

    Expr getHost() { result = this.getAttribute("host") }

    Expr getConfigPath() { result = this.getAttribute("config_path") }
  }
}
