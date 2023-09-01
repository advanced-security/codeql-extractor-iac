private import codeql.iac.YAML
private import codeql.files.FileSystem

predicate openapiFiles(Location loc) {
  loc.getFile().getBaseName() =
    [
      // Swagger JSON / YAML
      "swagger.yml", "swagger.yaml",
      // "swagger.json",
      // OpenAPI JSON / YAML
      "openapi.yml", "openapi.yaml",
      // "openapi.json",
    ]
}

private class Node extends YamlNode {
  Node() { openapiFiles(this.getLocation()) }
}

class OpenAPI extends Node, YamlDocument, YamlMapping {
  string getApiVersion() { result = this.lookup("openapi").toString() }

  YamlMapping getInfo() { result = this.lookup("info") }

  YamlSequence getServers() { result = this.lookup("servers") }
}
