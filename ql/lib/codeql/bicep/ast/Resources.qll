private import codeql.bicep.ast.internal.AstNodes
private import codeql.bicep.ast.internal.Resources
private import codeql.bicep.ast.Expr
private import codeql.bicep.ast.Object

final class Infrastructure extends BicepAstNode instanceof InfrastructureImpl {
  Statement getStatement(int i) { result = super.getStatement(i) }
}

final class Resource extends BicepAstNode instanceof ResourceImpl {
  string getResourceType() { result = super.getResourceType() }

  Identifier getIdentifier() { result = super.getIdentifier() }

  Object getBody() { result = super.getBody() }

  Expr getProperty(string name) { result = super.getProperty(name) }
}

final class Statement extends Expr instanceof StatementImpl { }

final class Comment extends BicepAstNode instanceof CommentImpl { }
