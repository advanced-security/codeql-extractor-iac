private import codeql.files.FileSystem
private import codeql.hcl.AST
private import codeql.iac.Dependencies
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
    RequiredProvider getRequiredProvider() {
      result = this.getAttribute("required_providers").getAChild()
    }

    /**
     * Get required version of Terraform.
     */
    string getRequiredVersion() {
      result = this.getAttribute("required_version").(StringLiteral).getValue()
    }
  }

  abstract class RequiredProvider extends Expr {
    /**
     * Gets the name of the provider.
     */
    abstract string getName();

    /**
     * Gets the version of the provider.
     */
    abstract string getVersion();

    /**
     * Gets the semantic version of the provider.
     */
    abstract SemanticVersion getSemanticVersion();

    /**
     * Gets the source of the provider.
     */
    abstract string getSource();
  }

  RequiredProvider getProviderByName(string name) {
    exists(RequiredProvider provider | provider.getName() = name | result = provider)
  }

  /**
   * Basic Terraform required provider String.
   */
  class BasicRequiredProvider extends RequiredProvider, StringLiteral {
    private Terraform terraform;

    BasicRequiredProvider() { this = terraform.getAttribute("required_providers").getAChild() }

    override string toString() { result = "RequiredProvider " + this.getName() }

    override string getName() { result = this.getParent().(Block).getAttributeName(this).getName() }

    override string getVersion() { result = this.getValue() }

    override SemanticVersion getSemanticVersion() { result = this.getValue() }

    /**
     * Basic providers are assumed to be from the Hashicorp namespace.
     */
    override string getSource() { result = "hashicorp/" + this.getName() }
  }

  /**
   * A Terraform required provider object.
   */
  class ComplexRequiredProvider extends RequiredProvider, Object {
    private Terraform terraform;

    ComplexRequiredProvider() { this = terraform.getAttribute("required_providers").getAChild() }

    override string toString() { result = "RequiredProvider " + this.getName() }

    override string getName() { result = this.getParent().(Block).getAttributeName(this).getName() }

    /**
     * Gets the source of the provider.
     */
    override string getSource() {
      result = this.getElementByName("source").(StringLiteral).getValue()
    }

    /**
     * Gets the version of the provider.
     */
    override string getVersion() {
      result = this.getElementByName("version").(StringLiteral).getValue()
    }

    override SemanticVersion getSemanticVersion() { result = this.getVersion() }
  }
}
