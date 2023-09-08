private import codeql.iac.YAML
private import codeql.files.FileSystem

module Compose {
  /**
   * A Compose file node.
   */
  private class Node extends YamlNode {
    Node() {
      this.getFile().getBaseName() =
        [
          // Compose
          "compose.yml", "compose.yaml",
          // Docker
          "docker-compose.yml", "docker-compose.yaml",
          // Podman
          "podman-compose.yml", "podman-compose.yaml",
        ]
    }
  }

  /**
   * Docker / Podman Compose file.
   */
  class Document extends Node, YamlDocument, YamlMapping {
    /**
     * Returns the version of the Compose file.
     */
    string getApiVersion() {
      result = this.lookup("version").toString().regexpReplaceAll("('|\")", "")
    }

    /**
     * Returns the services defined in the Compose file.
     */
    Service getServices() { result = this.lookup("services").getAChildNode() }
  }

  /**
   * A service defined in a Compose file.
   */
  class Service extends YamlMapping {
    Document compose;

    /**
     * Compose Service
     */
    Service() { compose.lookup("services").getAChildNode() = this }

    /**
     * Returns the name of the service.
     */
    string getName() {
      result = this.lookup("container_name").toString()
      // TODO get parent key name
    }
  }
}
