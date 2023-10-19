private import codeql.bicep.ast.Ast
private import codeql.bicep.ast.internal.Calls
private import codeql.bicep.ast.Expr

final class CallExpr extends AstNode instanceof CallExprImpl {
  Identifier getFunction() { result = super.getFunction() }

  Arguments getArguments() { result = super.getArguments() }
}

final class Arguments extends AstNode instanceof ArgumentsImpl {
  Expr getArgument(int i) { result = super.getArgument(i) }

  Expr getArguments() { result = super.getArguments() }
}

final class LambdaExpr extends AstNode instanceof LambdaExprImpl { }
