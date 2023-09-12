private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants

module AWS {
  /**
   * AWS resources.
   */
  class AwsResource extends Resource, Block {
    AwsResource() { this.getResourceType().regexpMatch("^aws.*") }
  }

  /**
   * AWS provider.
   */
  class AwsProvider extends Provider {
    AwsProvider() { this.getName() = "aws" }

    Expr getRegion() { result = this.getAttribute("region") }

    Expr getAccessKey() { result = this.getAttribute("access_key") }

    Expr getSecretKey() { result = this.getAttribute("secret_key") }
  }

  /**
   * AWS Database.
   */
  class Database extends AwsResource {
    Database() { this.getResourceType() = "aws_db_instance" }

    Expr getPassword() { result = this.getAttribute("password") }
  }
}
