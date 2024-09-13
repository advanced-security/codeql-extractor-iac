private import codeql.iac.YAML
private import codeql.files.FileSystem

/**
 * Helm Chart file.
 */
module HelmChart {
  private class Node extends YamlNode {
    Node() {
      // Chart file itself
      this.getFile().getExtension() = ["yml", "yaml"]
    }
  }

  /**
   * Helm Chart document.
   *
   * https://helm.sh/docs/topics/charts/
   */
  class Document extends Node, YamlDocument, YamlMapping {
    Document() { exists(this.lookup("apiVersion")) }

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
     * Get the Helm Chart spec.
     */
    Spec getSpec() { result = this.lookup("spec") }

    /**
     * Get the Helm Chart dependencies.
     */
    Dependency getDependencies() { result = this.lookup("dependencies").(YamlSequence).getAChild() }

    /**
     * Get the Helm Chart data.
     */
    HelmData getData() { result = this.lookup("data") }

    /**
     * Get the Helm Chart values.
     */
    HelmChartValues::Document getValues() { none() }
  }

  /**
   * Helm Chart spec.
   */
  class Spec extends Node, YamlMapping {
    private HelmChart::Document helm;

    Spec() { helm.lookup("spec") = this }

    boolean getPrivileged() { result = this.lookup("privileged").(YamlBool).getBoolValue() }

    SecurityContext getSecurityContext() { result = this.lookup("securityContext") }

    Container getContainers() { result = this.lookup("containers").(YamlSequence).getAChild() }
  }

  class HelmData extends Node, YamlMapping {
    private HelmChart::Document helm;

    HelmData() { helm.lookup("data") = this }

    override string toString() { result = "HelmData" }

    Node getName(string name) { result = this.lookup(name) }
  }

  /**
   * Helm Chart container.
   */
  class Container extends Node, YamlMapping {
    private HelmChart::Spec spec;

    Container() { spec.lookup("containers").getAChild() = this }

    override string toString() { result = "Container" }

    /**
     * Get the container name.
     */
    string getName() { result = yamlToString(this.lookup("name")) }

    /**
     * Get the container image.
     */
    string getImage() { result = yamlToString(this.lookup("image")) }

    /**
     * Get the container command.
     */
    YamlSequence getCommand() { result = this.lookup("command").(YamlSequence) }

    /**
     * Get the container security context.
     */
    SecurityContext getSecurityContext() { result = this.lookup("securityContext") }
  }

  /**
   * Helm Chart security context.
   */
  class SecurityContext extends Node, YamlMapping {
    private HelmChart::Spec spec;
    private HelmChart::Container container;

    SecurityContext() {
      spec.lookup("securityContext") = this or container.lookup("securityContext") = this
    }

    override string toString() { result = "SecurityContext" }

    /**
     * Get the container runAsUser.
     */
    int getRunAsUser() { result = this.lookup("runAsUser").(YamlInteger).getIntValue() }

    /**
     * Get the container runAsGroup.
     */
    int getRunAsGroup() { result = this.lookup("runAsUser").(YamlInteger).getIntValue() }

    /**
     * Get the container privilege.
     */
    boolean getPrivileged() { result = this.lookup("privileged").(YamlBool).getBoolValue() }

    /**
     * Get the container allowPrivilegeEscalation.
     */
    boolean getAllowPrivilegeEscalation() {
      result = this.lookup("allowPrivilegeEscalation").(YamlBool).getBoolValue()
    }
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

/**
 * Helm Chart values.
 *
 * https://helm.sh/docs/chart_template_guide/values_files/
 */
module HelmChartValues {
  class Document extends YamlMapping {
    Document() { this.getFile().getBaseName() = ["values.yaml", "values.yml"] }

    override string toString() { result = "HelmChart Value Document" }
  }
}
