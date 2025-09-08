/**
 * Classes and predicates for analyzing GitHub provider resources and configurations in HCL.
 * This module provides specific support for GitHub resources, data sources, and provider configurations
 * commonly used in Terraform for managing GitHub repositories, teams, and organization settings.
 */

private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants

/**
 * GitHub provider module containing classes for analyzing GitHub-specific HCL configurations.
 *
 * This module provides specialized classes for GitHub resources like repositories, teams,
 * webhooks, and other GitHub management features commonly defined in Terraform configurations.
 */
module GitHub {
  /**
   * A GitHub resource in HCL configuration.
   *
   * GitHub resources represent components that are managed through the GitHub API,
   * such as repositories, teams, organization settings, webhooks, etc.
   *
   * Example GitHub resources:
   * ```
   * resource "github_repository" "example" {
   *   name        = "example-repo"
   *   description = "My example repository"
   *   visibility  = "public"
   * }
   *
   * resource "github_team" "developers" {
   *   name        = "developers"
   *   description = "Development team"
   *   privacy     = "closed"
   * }
   * ```
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
