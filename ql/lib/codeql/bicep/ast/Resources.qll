private import codeql.bicep.ast.Ast
private import codeql.bicep.ast.internal.Resources
private import codeql.bicep.ast.Expr
private import codeql.bicep.ast.Object

final class Infrastructure extends AstNode instanceof InfrastructureImpl {
  Statement getStatement(int i) { result = super.getStatement(i) }
}

final class Resource extends AstNode instanceof ResourceImpl {
  string getResourceType() { result = super.getResourceType() }

  Identifier getIdentifier() { result = super.getIdentifier() }

  Object getBody() { result = super.getBody() }

  Expr getProperty(string name) { result = super.getProperty(name) }
}

final class Statement extends Expr instanceof StatementImpl { }

// Types
final class Type extends AstNode instanceof TypeImpl {
  string getType() { result = super.getType() }
}

final class BuiltInType extends AstNode instanceof BuiltinTypeImpl { }

final class PrimitiveType extends AstNode instanceof PrimitiveTypeImpl { }

final class Comment extends AstNode instanceof CommentImpl { }
