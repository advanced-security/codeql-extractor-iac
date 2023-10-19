private import codeql.bicep.ast.internal.AstNodes
private import codeql.bicep.ast.internal.Calls

final class CallExpr extends BicepAstNode instanceof CallExprImpl { }

final class LambdaExpr extends BicepAstNode instanceof LambdaExprImpl { }
