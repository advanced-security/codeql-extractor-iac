private import codeql.iac.YAML
private import codeql.files.FileSystem

module ARM {
  /**
   * Azure Resource Manager (ARM) templates file.
   */
  class Document extends YamlNode, YamlDocument, YamlMapping {
    Document() {
      // Check the filename
      this.getFile().getBaseName() = ["azuredeploy.json"]
      or
      // Check the schema
      yamlToString(this.lookup("$schema")).regexpMatch(".*schema\\.management\\.azure\\.com.*")
    }

    string getVersion() {
      result = this.lookup("contentVersion").toString().regexpReplaceAll("(\"|')", "")
    }

    Resource getResources() { result = this.lookup("resources").(YamlCollection).getAChild() }

    Resource getResource(string name_or_type) {
      exists(Resource resource | resource = this.getResources() |
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
  class Resource extends YamlMapping {
    private Document arm;

    Resource() { arm.lookup("resources").getAChildNode() = this }

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
    ResourceProperties getProperties() { result = this.lookup("properties") }
  }

  /**
   * Azure Resource Manager (ARM) resource properties.
   */
  class ResourceProperties extends YamlMapping {
    private Resource resource;

    ResourceProperties() { resource.lookup("properties") = this }

    /**
     * Get the property with the given name.
     */
    YamlNode getProperty(string name) { result = this.lookup(name) }

    SecurityRule getSecurityRules() {
      result = this.getProperty("securityRules").(YamlSequence).getAChild()
    }
  }

  class SecurityRule extends YamlMapping {
    private ResourceProperties properties;

    SecurityRule() { properties.getProperty("securityRules").(YamlSequence).getAChildNode() = this }

    /**
     * Get the security rule name.
     */
    string getName() { result = this.lookup("name").toString().regexpReplaceAll("(\"|')", "") }

    YamlNode getProperty(string name) {
      result = this.lookup("properties").(YamlMapping).lookup(name)
    }
  }
}
