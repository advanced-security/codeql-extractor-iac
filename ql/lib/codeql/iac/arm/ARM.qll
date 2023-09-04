private import codeql.iac.YAML
private import codeql.files.FileSystem

/**
 * Azure Resource Manager (ARM) templates file.
 */
class AzureResourceManager extends YamlNode, YamlDocument, YamlMapping {
  AzureResourceManager() {
    // Check the filename
    this.getFile().getBaseName() = ["azuredeploy.json"]
    or
    // Check the schema
    this.lookup("$schema")
        .toString()
        .regexpReplaceAll("(\"|')", "")
        .regexpMatch(".*schema\\.management\\.azure\\.com.*")
  }

  string getVersion() {
    result = this.lookup("contentVersion").toString().regexpReplaceAll("(\"|')", "")
  }

  ArmResource getResources() { result = this.lookup("resources").(YamlCollection).getAChild() }

  ArmResource getResource(string name_or_type) {
    exists(ArmResource resource | resource = this.getResources() |
      resource.getName() = name_or_type
      or
      resource.getType() = name_or_type and
      result = resource
    )
  }
}

/**
 * Azure Resource Manager (ARM) resource.
 */
class ArmResource extends YamlMapping {
  private AzureResourceManager arm;

  ArmResource() { arm.lookup("resources").getAChildNode() = this }

  /**
   * Get the resource type.
   */
  string getType() { result = this.lookup("type").toString().regexpReplaceAll("(\"|')", "") }

  /**
   * Get the resource name.
   */
  string getName() { result = this.lookup("name").toString().regexpReplaceAll("(\"|')", "") }

  /**
   * Get the resource properties.
   */
  ArmResourceProperties getProperties() { result = this.lookup("properties") }
}

/**
 * Azure Resource Manager (ARM) resource properties.
 */
class ArmResourceProperties extends YamlMapping {
  private ArmResource resource;

  ArmResourceProperties() { resource.lookup("properties") = this }

  /**
   * Get the property with the given name.
   */
  YamlNode getProperty(string name) { result = this.lookup(name) }

  ArmSecurityRule getSecurityRules() {
    result = this.getProperty("securityRules").(YamlSequence).getAChild()
  }
}

class ArmSecurityRule extends YamlMapping {
  private ArmResourceProperties properties;

  ArmSecurityRule() {
    properties.getProperty("securityRules").(YamlSequence).getAChildNode() = this
  }

  /**
   * Get the security rule name.
   */
  string getName() { result = this.lookup("name").toString().regexpReplaceAll("(\"|')", "") }

  YamlNode getProperty(string name) {
    result = this.lookup("properties").(YamlMapping).lookup(name)
  }
}
