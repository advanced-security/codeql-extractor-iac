private import codeql.iac.YAML
private import codeql.files.FileSystem

module HelmChart {
  private class Node extends YamlNode {
    Node() { this.getFile().getBaseName() = ["Chart.yml", "Chart.yaml"] }
  }

  /**
   * Helm Chart document.
   *
   * https://helm.sh/docs/topics/charts/
   */
  class Document extends Node, YamlDocument, YamlMapping {
    override string toString() { result = "HelmChart Document" }

    /**
     * Get the API version of the Helm Chart.
     */
    string getApiVersion() { result = yamlToString(this.lookup("apiVersion")) }

    /**
     * Get the Kubernetes version that this chart is compatible with.
     */
    string getKubernetesVersion() { result = yamlToString(this.lookup("kubeVersion")) }

    /**
     * Get the Helm Chart application version.
     */
    string getVersion() { result = yamlToString(this.lookup("version")) }

    /**
     * Get the Helm Chart name.
     */
    string getName() { result = yamlToString(this.lookup("name")) }

    /**
     * Get the Helm Chart type.
     */
    string getType() { result = yamlToString(this.lookup("type")) }

    /**
     * Get the Helm Chart dependencies.
     */
    Dependency getDependencies() { result = this.lookup("dependencies").(YamlSequence).getAChild() }

    /**
     * Get the Helm Chart values.
     */
    HelmChartValues::Document getValues() { none() }
  }

  class Dependency extends Node, YamlMapping {
    private HelmChart::Document helm;

    Dependency() { helm.lookup("dependencies").(YamlSequence).getAChild() = this }

    override string toString() { result = this.getName() }

    string getName() { result = yamlToString(this.lookup("name")) }

    string getVersion() { result = yamlToString(this.lookup("version")) }

    string getRepository() { result = yamlToString(this.lookup("repository")) }
  }
}

module HelmChartValues {
  class Document extends YamlMapping {
    Document() { this.getFile().getBaseName() = ["values.yaml", "values.yml"] }

    override string toString() { result = "HelmChart Value Document" }
  }
}
