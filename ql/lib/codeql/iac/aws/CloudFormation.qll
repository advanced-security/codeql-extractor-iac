private import codeql.iac.YAML
private import codeql.files.FileSystem

/**
 * AWS CloudFormation.
 */
module CloudFormation {
  /**
   * An AWS CloudFormation Variable node.
   *
   * This is used as a base class for other CloudFormation nodes that can be
   * referenced by other nodes.
   */
  abstract class Variable extends YamlNode {
    abstract string getName();

    override string toString() { result = "CloudFormation Variable `" + this.getName() + "`" }
  }

  /**
   * Find a CloudFormation variable by reference node.
   */
  Variable findByReference(YamlNode node) {
    exists(Variable vars |
      // Same file reference
      vars.getFile().getAbsolutePath() = node.getFile().getAbsolutePath() and
      (
        // Support for JSON References
        vars.getName() = node.(YamlMapping).lookup("Ref").(YamlString).getValue()
        or
        // Support for YAML References
        vars.getName() = node.(YamlScalar).getValue()
      )
    |
      result = vars
    )
  }

  /**
   * An AWS CloudFormation file node.
   */
  class Document extends YamlNode, YamlDocument, YamlMapping {
    Document() { exists(this.lookup("AWSTemplateFormatVersion")) }

    override string toString() { result = "CloudFormation Document" }

    Resource getResources() { result = this.lookup("Resources").getAChild() }

    Output getOutputs() { result = this.lookup("Outputs").getAChild() }
  }

  /**
   * An AWS CloudFormation Resource node.
   */
  class Resource extends Variable, YamlNode, YamlMapping {
    private Document document;

    Resource() { this = document.lookup("Resources").getAChild() }

    override string toString() { result = "CloudFormation Resource" }

    override string getName() {
      exists(YamlNode pair, string key_name |
        pair = this.getParentNode().(YamlMapping).getChild(_) and
        key_name = pair.(YamlString).getValue()
      |
        result = pair.toString()
      )
    }

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
   * An AWS CloudFormation Resource Properties node.
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
   * An AWS CloudFormation Outputs node.
   */
  class Output extends YamlNode, YamlMapping {
    private Document document;

    Output() { this = document.lookup("Outputs").getAChild() }

    override string toString() { result = "CloudFormation Outputs" }
  }

  /**
   * An AWS CloudFormation S3 Bucket.
   */
  class S3Bucket extends Resource {
    S3Bucket() { this.getType() = "AWS::S3::Bucket" }

    override string toString() { result = "CloudFormation S3 Bucket" }

    /**
     * Get Bucket Policy if it exists.
     */
    S3BucketPolicy getBucketPolicy() {
      exists(S3BucketPolicy policies | policies.getBucket() = this | result = policies)
    }

    /**
     * Get the bucket access control.
     */
    string getAccessControl() {
      result = this.getProperties().getProperty("AccessControl").(YamlString).getValue()
    }
  }

  /**
   * An AWS CloudFormation S3 Bucket Policy.
   */
  class S3BucketPolicy extends Resource {
    S3BucketPolicy() { this.getType() = "AWS::S3::BucketPolicy" }

    override string toString() { result = "CloudFormation S3 Bucket Policy" }

    /**
     * Get the bucket policy.
     */
    YamlNode getBucket() {
      result = findByReference(this.getProperties().getProperty("Bucket"))
      // exists(Variable node, S3Bucket buckets |
      //   node = this.getProperties().getProperty("Bucket") and
      //   // Support for JSON References
      //   exists(YamlMapping map | map = node |
      //     buckets.getName() = map.lookup("Ref").(YamlString).getValue()
      //   )
      //   or
      //   // Support for YAML References
      //   exists(YamlScalar scalar | scalar.getValue().matches("^!Ref .*$") |
      //     buckets.getName() = scalar.getValue()
      //   )
      // |
      //   result = buckets
      // )
    }
  }
}
