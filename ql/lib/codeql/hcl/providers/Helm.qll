private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants

module TerraformHelmChart {
  /**
   * HelmChart resources.
   */
  class HelmResource extends Resource, Block {
    HelmResource() { this.getResourceType().regexpMatch("^helm_.*") }
  }

  /**
   * Helm provider.
   */
  class HelmProvider extends Provider {
    HelmProvider() { this.getName() = "helm" }

    HelmProviderRegistry getRegistry() { result = this.getAttribute("registry") }
  }

  /**
   * Helm provider registry.
   */
  class HelmProviderRegistry extends Block {
    private HelmProvider provider;

    HelmProviderRegistry() { provider.getAttribute("registry") = this }

    /**
     * Helm registry URL.
     */
    Expr getUrl() { result = this.getAttribute("url") }

    /**
     * Helm registry username.
     */
    Expr getUsername() { result = this.getAttribute("username") }

    /**
     * Helm registry password.
     */
    Expr getPassword() { result = this.getAttribute("password") }
  }

  /**
   * Helm Chart release.
   */
  class Release extends HelmResource {
    Release() { this.getResourceType() = "helm_release" }

    override string getName() { result = this.getAttribute("name").(StringLiteral).getValue() }

    string getChart() { result = this.getAttribute("chart").(StringLiteral).getValue() }

    string getRepository() { result = this.getAttribute("repository").(StringLiteral).getValue() }

    ReleaseSet getSets() { result = this.getAttribute("set") }

    ReleaseSet getSet(string name) {
      exists(ReleaseSet set | set = this.getSets() | set.getName() = name and result = set)
    }
  }

  /**
   * Value block with custom values to be merged with the values yaml.
   *
   * https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release#set
   */
  class ReleaseSet extends Block {
    private Release release;

    ReleaseSet() { release.getAttribute("set").(Block) = this }

    string getName() { result = this.getAttribute("name").(StringLiteral).getValue() }

    Expr getValue() { result = this.getAttribute("value") }
  }
}
