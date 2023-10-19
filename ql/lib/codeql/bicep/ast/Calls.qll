private import codeql.bicep.ast.Ast
private import codeql.bicep.ast.internal.Calls

final class CallExpr extends AstNode instanceof CallExprImpl { }

final class LambdaExpr extends AstNode instanceof LambdaExprImpl { }
