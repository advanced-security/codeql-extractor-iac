private import codeql.iac.YAML
private import codeql.files.FileSystem

/**
 * AWS CloudFormation.
 */
module CloudFormation {
  /**
   * AWS CloudFormation file node.
   */
  private class Node extends YamlDocument {
    Node() {
      this.getFile().getBaseName() =
        [
          // Azure Deploy files
          "azuredeploy.json",
        ]
    }
  }

  /**
   * AWS CloudFormation file.
   */
  class CloudFormation extends Node, YamlDocument, YamlMapping { }
}
