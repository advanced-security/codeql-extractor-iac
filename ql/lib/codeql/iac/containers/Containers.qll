private import codeql.iac.ast.internal.AstNodes
private import codeql.iac.ast.AstNode::Containers
private import codeql.Locations
private import codeql.files.FileSystem

/**
 * A container definition.
 */
class ContainerDefinition extends AstNode, TSourceFile {
  private DOCKERFILE::SourceFile sourceFile;

  override string getAPrimaryQlClass() { result = "ContainerDefinition" }

  ContainerDefinition() { this = TSourceFile(sourceFile) }
}
