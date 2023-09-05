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
  class OpenApi extends Node, YamlDocument, YamlMapping {
    /**
     * Get the OpenAPI info.
     */
    OpenApiInfo getInfo() { result = this.lookup("info") }

    string getApiVersion() { result = this.lookup("openapi").toString() }

    string getHost() { result = this.lookup("host").toString() }

    string getSchemes() {
      result =
        this.lookup("schemes")
            .(YamlCollection)
            .getAChild()
            .toString()
            .regexpReplaceAll("(\"|')", "")
    }

    string getBasePath() { result = this.lookup("basePath").toString() }

    string getProduces() { result = this.lookup("produces").toString() }

    /**
     * Get the OpenAPI servers.
     */
    OpenApiServers getServers() { result = this.lookup("servers") }

    /**
     * Get the OpenAPI definitions.
     */
    OpenApiDefinitions getDefinitions() { result = this.lookup("definitions") }

    /**
     * Get the OpenAPI paths.
     */
    OpenApiPath getPaths() { result = this.lookup("paths") }
  }

  /**
   * OpenAPI info.
   */
  class OpenApiInfo extends YamlMapping {
    private OpenApi oapi;

    OpenApiInfo() { oapi.lookup("info") = this }

    /**
     * Get the API title.
     */
    string getTitle() { result = this.lookup("title").toString() }

    /**
     * Get the API description.
     */
    string getDescription() { result = this.lookup("description").toString() }

    /**
     * Get the API version.
     */
    string getVersion() { result = this.lookup("version").toString() }
  }

  /**
   * OpenAPI servers.
   */
  class OpenApiServers extends YamlSequence {
    private OpenApi oapi;

    OpenApiServers() { oapi.lookup("servers") = this }

    OpenApiServer getServers() { result = this.getAChild() }
  }

  /**
   * OpenAPI server.
   */
  class OpenApiServer extends Node, YamlMapping {
    private OpenApiServers oapis;

    OpenApiServer() { oapis.getAChild() = this }

    string getUrl() { result = this.lookup("url").(YamlString).toString() }

    string getDescription() { result = this.lookup("description").(YamlString).toString() }
  }

  /**
   * OpenAPI paths.
   */
  class OpenApiPath extends Node, YamlMapping {
    private OpenApi oapi;

    OpenApiPath() { oapi.lookup("paths") = this }

    /**
     * Get all paths.
     */
    YamlNode getPaths() { result = this.getAChild().(YamlString) }
  }

  /**
   * OpenAPI definitions.
   */
  class OpenApiDefinitions extends YamlMapping {
    private OpenApi oapi;

    OpenApiDefinitions() { oapi.lookup("definitions") = this }
  }
}
