private import codeql.files.FileSystem

class TerraformFiles extends File {
  TerraformFiles() { this.getBaseName().regexpMatch(".*.(tf|hcl)$") }
}
