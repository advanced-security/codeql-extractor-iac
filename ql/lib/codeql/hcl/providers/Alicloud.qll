private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants

module Alicloud {
  /**
   * Alibaba Cloud resources.
   */
  class AlicloudResource extends Resource, Block {
    AlicloudResource() { this.getResourceType().regexpMatch("^alicloud.*") }
  }

  /**
   * Alibaba Cloud provider.
   */
  class AlicloudProvider extends Provider {
    AlicloudProvider() { this.getName() = "alicloud" }
  }
}
