private import codeql.files.FileSystem

module Bicep {
  /**
   * All extracted Bicep files.
   */
  class BicepFile extends File {
    BicepFile() { this.getExtension() = "bicep" }
  }
}
