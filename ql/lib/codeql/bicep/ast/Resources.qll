import codeql.iac.ast.internal.Bicep
import codeql.bicep.ast.AstNodes
import codeql.bicep.ast.Literal
import codeql.bicep.ast.Object

class Resource extends BicepAstNode, TResourceDeclaration {
  private BICEP::ResourceDeclaration resource;

  override string getAPrimaryQlClass() { result = "ResourceDeclaration" }

  Resource() { this = TResourceDeclaration(resource) }

  Object getBody() { toBicepTreeSitter(result) = resource.getAFieldOrChild() }

  Expr getProperty(string name) { result = this.getBody().getProperty(name) }
}
