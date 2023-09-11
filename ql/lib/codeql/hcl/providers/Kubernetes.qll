private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants

module Kubernetes {
  /**
   * Kubernetes resources.
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
