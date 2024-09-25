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

  IdentifierImpl getFunction() { toBicepTreeSitter(result) = cexpr.getFunction() }

  ArgumentsImpl getArguments() { toBicepTreeSitter(result) = cexpr.getArguments() }
}

class ArgumentsImpl extends BicepAstNode, TArguments {
  private BICEP::Arguments args;

  override string getAPrimaryQlClass() { result = "Arguments" }

  ArgumentsImpl() { this = TArguments(args) }

  ExprImpl getArgument(int i) { toBicepTreeSitter(result) = args.getChild(i) }

  ExprImpl getArguments() { toBicepTreeSitter(result) = args.getChild(_) }
}

/**
 * A Bicep lambda expression.
 */
class LambdaExprImpl extends ExprImpl, TLambdaExpression {
  BICEP::LambdaExpression lexpr;

  override string getAPrimaryQlClass() { result = "LambdaExpr" }

  LambdaExprImpl() { this = TLambdaExpression(lexpr) }
}
