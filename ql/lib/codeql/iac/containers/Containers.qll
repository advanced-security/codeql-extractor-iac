private import codeql.Locations
private import codeql.files.FileSystem
private import codeql.iac.ast.internal.AstNodes
private import codeql.iac.ast.Container

/**
 * A container definition.
 */
class ContainerDefinition extends ContainerAstNode, TSourceFile {
  private DOCKERFILE::SourceFile sourceFile;

  override string getAPrimaryQlClass() { result = "ContainerDefinition" }

  ContainerDefinition() { this = TSourceFile(sourceFile) }
}
