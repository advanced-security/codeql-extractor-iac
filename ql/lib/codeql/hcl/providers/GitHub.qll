private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants

module GitHub {
  /**
   * GitHub resources.
   */
  class GitHubResource extends Resource, Block {
    GitHubResource() { this.getResourceType().regexpMatch("^github.*") }
  }

  /**
   * GitHub provider.
   */
  class GitHubProvider extends Provider {
    GitHubProvider() { this.getName() = "github" }
  }

  /**
   * GitHub Repository.
   */
  class Repository extends GitHubResource {
    Repository() { this.getResourceType() = "github_repository" }

    override string toString() { result = "Repository " + this.getName() }

    override string getName() { result = this.getAttribute("name").(StringLiteral).getValue() }

    string getDescription() { result = this.getAttribute("description").(StringLiteral).getValue() }

    string getVisibility() { result = this.getAttribute("visibility").(StringLiteral).getValue() }
  }
}
