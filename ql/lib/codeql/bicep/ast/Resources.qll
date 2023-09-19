private import codeql.iac.ast.internal.Bicep
private import codeql.bicep.ast.AstNodes
private import codeql.bicep.ast.Literal
private import codeql.bicep.ast.Object

class Resource extends BicepAstNode, TResourceDeclaration {
  private BICEP::ResourceDeclaration resource;

  override string getAPrimaryQlClass() { result = "ResourceDeclaration" }

  Resource() { this = TResourceDeclaration(resource) }

  Object getBody() { toBicepTreeSitter(result) = resource.getAFieldOrChild() }

  Expr getProperty(string name) { result = this.getBody().getProperty(name) }
}
