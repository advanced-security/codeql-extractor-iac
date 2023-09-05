private import codeql.iac.YAML
private import codeql.files.FileSystem

module HelmChart {
  private class Node extends YamlNode {
    Node() { this.getFile().getBaseName() = ["Chart.yml", "Chart.yaml"] }
  }

  /**
   * Helm Chart document.
   */
  class Document extends Node, YamlDocument, YamlMapping {
    string getApiVersion() { result = this.lookup("apiVersion").toString() }

    string getVersion() { result = this.lookup("version").toString() }

    string getName() { result = this.lookup("name").toString() }

    string getType() { result = this.lookup("type").toString() }
  }
}
