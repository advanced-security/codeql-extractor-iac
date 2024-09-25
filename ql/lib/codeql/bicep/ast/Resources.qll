private import codeql.bicep.ast.Ast
private import codeql.bicep.ast.internal.Resources
private import codeql.bicep.ast.Expr
private import codeql.bicep.ast.Object

final class Infrastructure extends AstNode instanceof InfrastructureImpl {
  Stmt getStatement(int i) { result = super.getStatement(i) }

  Stmt getStatements() { result = super.getStatements() }
}

final class Stmt extends AstNode instanceof StmtImpl { }

final class Statement extends Stmt instanceof StatementImpl {
  Expr getExpr() { result = super.getAChild() }
}

final class Resource extends Stmt instanceof ResourceImpl {
  string toString() { result = "Resource" }

  string getResourceType() { result = super.getResourceType() }

  Identifier getIdentifier() { result = super.getIdentifier() }

  Object getBody() { result = super.getBody() }

  Expr getProperty(string name) { result = super.getProperty(name) }
}

final class ParameterDeclaration extends Stmt instanceof ParameterDeclarationImpl {
  Identifier getName() { result = super.getName() }

  Type getType() { result = super.getType() }

  Expr getDefaultValue() { result = super.getDefaultValue() }
}

final class Decorators extends Stmt instanceof DecoratorsImpl {
  string toString() { result = "Decorators" }

  Decorator getDecorator(int i) { result = super.getDecorator(i) }

  Decorator getDecorators() { result = super.getDecorators() }
}

final class Decorator extends Stmt instanceof DecoratorImpl { }

// Types
final class Type extends AstNode instanceof TypeImpl {
  string getType() { result = super.getType() }
}

final class BuiltInType extends AstNode instanceof BuiltinTypeImpl { }

final class PrimitiveType extends AstNode instanceof PrimitiveTypeImpl { }

final class Comment extends AstNode instanceof CommentImpl { }
