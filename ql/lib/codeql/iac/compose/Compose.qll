private import codeql.iac.YAML
private import codeql.files.FileSystem

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
class Compose extends Node, YamlDocument, YamlMapping {
  /**
   * Returns the version of the Compose file.
   */
  string getApiVersion() {
    result = this.lookup("version").toString().regexpReplaceAll("('|\")", "")
  }

  /**
   * Returns the services defined in the Compose file.
   */
  ComposeService getServices() { result = this.lookup("services").getAChildNode() }
}

/**
 * A service defined in a Compose file.
 */
class ComposeService extends YamlMapping {
  Compose compose;

  /**
   * Compose Service
   */
  ComposeService() { compose.lookup("services").getAChildNode() = this }

  /**
   * Returns the name of the service.
   */
  string getName() {
    result = this.lookup("container_name").toString()
    // TODO get parent key name
  }
}
