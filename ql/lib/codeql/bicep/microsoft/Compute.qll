private import codeql.Locations
private import codeql.bicep.ast.Expr
private import codeql.bicep.ast.Object
private import codeql.bicep.ast.Resources
private import codeql.bicep.ast.Literal

module Compute {
  class Disks extends Resource {
    Disks() { this.getResourceType().regexpMatch("^Microsoft.Compute/disks@.*") }
  }

  class DisksProperties extends Object {
    private Disks disks;

    DisksProperties() { this = disks.getProperty("properties") }

    Object getEncryptionSettings() { result = this.getProperty("encryptionSettingsCollection") }

    boolean getEncryptionEnabled() {
      result = this.getEncryptionSettings().getProperty("enabled").(BooleanLiteral).getBool()
    }
  }
}
