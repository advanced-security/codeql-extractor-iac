private import codeql.iac.YAML
private import codeql.files.FileSystem

module HelmChart {
  private class Node extends YamlNode {
    Node() { this.getFile().getBaseName() = ["Chart.yml", "Chart.yaml"] }
  }

  /**
   * Helm Chart document.
   */
  class HelmChartDocument extends Node, YamlDocument, YamlMapping {
    string getApiVersion() { result = yamlToString(this.lookup("apiVersion")) }

    string getVersion() { result = yamlToString(this.lookup("version")) }

    string getName() { result = yamlToString(this.lookup("name")) }

    string getType() { result = yamlToString(this.lookup("type")) }
  }
}
