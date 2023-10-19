private import codeql.iac.ast.internal.Bicep
private import codeql.bicep.ast.internal.AstNodes
private import codeql.bicep.ast.internal.Expr

/**
 * A Bicep call expression.
 */
class CallExprImpl extends ExprImpl, TCallExpression {
  BICEP::CallExpression cexpr;

  override string getAPrimaryQlClass() { result = "CallExpr" }

  CallExprImpl() { this = TCallExpression(cexpr) }
}

/**
 * A Bicep lambda expression.
 */
class LambdaExprImpl extends ExprImpl, TLambdaExpression {
  BICEP::LambdaExpression lexpr;

  override string getAPrimaryQlClass() { result = "LambdaExpr" }

  LambdaExprImpl() { this = TLambdaExpression(lexpr) }
}
