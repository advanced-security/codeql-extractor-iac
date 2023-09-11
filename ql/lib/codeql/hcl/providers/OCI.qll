private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants

module OCI {
  /**
   * Oracle resources.
   */
  class OracleResource extends Resource, Block {
    OracleResource() { this.getResourceType().regexpMatch("^oci.*") }
  }

  /**
   * Oracle provider.
   */
  class OracleProvider extends Provider {
    OracleProvider() { this.getName() = "oci" }
  }
}
