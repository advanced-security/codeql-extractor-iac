private import codeql.iac.YAML
private import codeql.files.FileSystem

module OpenApi {
  /**
   * OpenAPI Node
   */
  private class Node extends YamlNode {
    Node() {
      this.getLocation().getFile().getBaseName() =
        [
          // Swagger JSON / YAML
          "swagger.yml", "swagger.yaml", "swagger.json",
          // OpenAPI JSON / YAML
          "openapi.yml", "openapi.yaml", "openapi.json",
        ]
      or
      // Swagger JSON 2.0
      exists(this.(YamlMapping).lookup("swagger"))
    }
  }

  /**
   * OpenAPI document.
   */
  class Document extends Node, YamlDocument, YamlMapping {
    override string toString() { result = "OpenApi Document" }

    /**
     * Get the OpenAPI info.
     */
    Info getInfo() { result = this.lookup("info") }

    /**
     * Get the OpenAPI version.
     */
    string getApiVersion() { result = yamlToString(this.lookup("openapi")) }

    /**
     * Get the OpenAPI host.
     */
    string getHost() { result = yamlToString(this.lookup("host")) }

    /**
     * Get the OpenAPI schemes.
     */
    string getSchemes() {
      result = yamlToString(this.lookup("schemes").(YamlCollection).getAChild())
    }

    /**
     * Get the base path.
     */
    string getBasePath() { result = yamlToString(this.lookup("basePath")) }

    /**
     * Get the full base path.
     */
    string getFullBasePath() {
      // No scheme
      not exists(this.getSchemes()) and
      result = this.getHost() + this.getBasePath()
      or
      // With scheme
      result = this.getSchemes() + "://" + this.getHost() + this.getBasePath()
    }

    /**
     * Get the OpenAPI consumes.
     */
    string getProduces() { result = yamlToString(this.lookup("produces")) }

    /**
     * Get the OpenAPI servers.
     */
    Servers getServers() { result = this.lookup("servers") }

    /**
     * Get the OpenAPI definitions.
     */
    Definitions getDefinitions() { result = this.lookup("definitions") }

    /**
     * Get the OpenAPI paths.
     */
    Path getPaths() { result = this.lookup("paths") }
  }

  /**
   * OpenAPI info.
   */
  class Info extends YamlMapping {
    private Document oapi;

    Info() { oapi.lookup("info") = this }

    override string toString() { result = "OpenApi Information" }

    /**
     * Get the API title.
     */
    string getTitle() { result = yamlToString(this.lookup("title")) }

    /**
     * Get the API description.
     */
    string getDescription() { result = yamlToString(this.lookup("description")) }

    /**
     * Get the API version.
     */
    string getVersion() { result = yamlToString(this.lookup("version")) }
  }

  /**
   * OpenAPI servers.
   */
  class Servers extends YamlSequence {
    private Document oapi;

    Servers() { oapi.lookup("servers") = this }

    override string toString() { result = "OpenApi Servers" }

    /**
     * Get a server from the servers list.
     */
    Server getServers() { result = this.getAChild() }
  }

  /**
   * OpenAPI server.
   */
  class Server extends Node, YamlMapping {
    private Servers oapis;

    Server() { oapis.getAChild() = this }

    override string toString() { result = "OpenApi Server" }

    /**
     * Get the server URL.
     */
    string getUrl() { result = yamlToString(this.lookup("url")) }

    /**
     * Get the server description.
     */
    string getDescription() { result = yamlToString(this.lookup("description")) }
  }

  /**
   * OpenAPI paths.
   */
  class Path extends Node, YamlMapping {
    private Document oapi;

    Path() { oapi.lookup("paths") = this }

    override string toString() { result = "OpenApi Path" }

    /**
     * Get all paths.
     */
    YamlNode getPaths() { result = this.getAChild().(YamlString) }
  }

  /**
   * OpenAPI definitions.
   */
  class Definitions extends YamlMapping {
    private Document oapi;

    Definitions() { oapi.lookup("definitions") = this }

    override string toString() { result = "OpenApi Definitions" }
  }
}
