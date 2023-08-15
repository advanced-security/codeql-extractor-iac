private import codeql.files.FileSystem

class HelmChartFile extends File {
  HelmChartFile() { this.getBaseName().regexpMatch("(?i).*Chart.(yml|yaml)$") }
}
