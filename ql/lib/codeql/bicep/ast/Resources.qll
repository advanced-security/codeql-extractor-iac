private import codeql.iac.ast.internal.Bicep
private import codeql.bicep.ast.AstNodes
private import codeql.bicep.ast.Literal
private import codeql.bicep.ast.Object
private import codeql.bicep.ast.Expr

Resource resolveResource(Expr expr) {
  exists(Resource resource |
    // Object having an id property needs to be resolved
    // {resource.id}.id
    exists(MemberExpr memexpr |
      memexpr = expr.(Object).getProperty("id") and
      memexpr.getObject().(Identifier).getName() = resource.getIdentifier().(Identifier).getName()
    |
      result = resource
    )
    or
    exists(Identifier ident |
      ident = expr and
      ident.getName() = resource.getIdentifier().(Identifier).getName()
    |
      result = resource
    )
  )
}

class Resource extends BicepAstNode, TResourceDeclaration {
  private BICEP::ResourceDeclaration resource;

  override string getAPrimaryQlClass() { result = "ResourceDeclaration" }

  Resource() { this = TResourceDeclaration(resource) }

  string getResourceType() {
    exists(StringLiteral s | toBicepTreeSitter(s) = resource.getAFieldOrChild() |
      result = s.getValue()
    )
  }

  /**
   * A name given to the resource instance that is unique within the template.
   */
  Identifier getIdentifier() { toBicepTreeSitter(result) = resource.getChild(0) }

  Object getBody() { toBicepTreeSitter(result) = resource.getAFieldOrChild() }

  Expr getProperty(string name) { result = this.getBody().getProperty(name) }

  override Resource getParent() { result = resolveResource(this.getProperty("parent")) }
}
