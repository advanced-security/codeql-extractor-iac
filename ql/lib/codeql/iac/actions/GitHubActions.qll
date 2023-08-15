private import codeql.files.FileSystem

class GitHubActionsFile extends File {
  GitHubActionsFile() { this.getRelativePath().regexpMatch("^.github/workflows/.*.(yml|yaml)$") }
}
