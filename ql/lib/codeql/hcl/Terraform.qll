private import codeql.files.FileSystem
private import codeql.hcl.AST
private import Resources

module Terraform {
  /**
   * A Terraform file.
   */
  class TerraformFile extends File {
    TerraformFile() { this.getBaseName().regexpMatch(".*.(tf|hcl)$") }
  }

  /**
   * A Terraform settings block.
   */
  class Terraform extends Block {
    Terraform() { this.hasType("terraform") }

    /**
     * Get the required provider.
     */
    Object getRequiredProvider() { result = this.getAttribute("required_providers").getAChild() }

    /**
     * Get required version of Terraform.
     */
    string getRequiredVersion() {
      result = this.getAttribute("required_version").(StringLiteral).getValue()
    }
  }

  /**
   * A Terraform required provider object.
   */
  class RequiredProvider extends Object {
    private Terraform terraform;

    RequiredProvider() { this = terraform.getAttribute("required_providers").getAChild() }

    override string toString() { result = "RequiredProvider" }

    /**
     * Gets the source of the provider.
     */
    string getSource() { result = this.getElementByName("source").(StringLiteral).getValue() }

    /**
     * Gets the version of the provider.
     */
    string getVersion() { result = this.getElementByName("version").(StringLiteral).getValue() }
  }
}
