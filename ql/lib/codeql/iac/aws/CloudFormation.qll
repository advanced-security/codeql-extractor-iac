private import codeql.iac.YAML
private import codeql.files.FileSystem

/**
 * AWS CloudFormation.
 */
module CloudFormation {
  /**
   * AWS CloudFormation file node.
   */
  class Document extends YamlNode, YamlDocument, YamlMapping {
    Document() { exists(this.lookup("AWSTemplateFormatVersion")) }

    override string toString() { result = "CloudFormation Document" }

    Resource getResources() { result = this.lookup("Resources").getAChild() }

    Output getOutputs() { result = this.lookup("Outputs").getAChild() }
  }

  /**
   * AWS CloudFormation Resource node.
   */
  class Resource extends YamlNode, YamlMapping {
    private Document document;

    Resource() { this = document.lookup("Resources").getAChild() }

    override string toString() { result = "CloudFormation Resource" }

    /**
     * Get the resource type.
     */
    string getType() { result = this.lookup("Type").(YamlString).getValue() }

    /**
     * Get the resource properties.
     */
    ResourceProperties getProperties() { result = this.lookup("Properties") }
  }

  /**
   * AWS CloudFormation Resource Properties node.
   */
  class ResourceProperties extends YamlNode, YamlMapping {
    private Resource resource;

    ResourceProperties() { this = resource.lookup("Properties") }

    override string toString() { result = "CloudFormation Resource Properties" }

    /**
     * Get the resource property value.
     */
    YamlNode getProperty(string key) { result = this.lookup(key) }
  }

  /**
   * AWS CloudFormation Outputs node.
   */
  class Output extends YamlNode, YamlMapping {
    private Document document;

    Output() { this = document.lookup("Outputs").getAChild() }

    override string toString() { result = "CloudFormation Outputs" }
  }

  class S3Bucket extends Resource {
    S3Bucket() { this.getType() = "AWS::S3::Bucket" }

    /**
     * Get the bucket access control.
     */
    string getAccessControl() {
      result = this.getProperties().getProperty("AccessControl").(YamlString).getValue()
    }
  }
}
