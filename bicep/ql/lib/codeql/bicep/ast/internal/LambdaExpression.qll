/**
 *  Internal implementation for LambdaExpression
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Expr


/**
 *  A LambdaExpression AST Node.
 */
class LambdaExpressionImpl extends TLambdaExpression, ExprImpl {
  private BICEP::LambdaExpression ast;

  override string getAPrimaryQlClass() { result = "LambdaExpression" }

  LambdaExpressionImpl() { this = TLambdaExpression(ast) }

  override string toString() { result = ast.toString() }



}