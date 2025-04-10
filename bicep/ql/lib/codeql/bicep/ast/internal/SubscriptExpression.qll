/**
 *  Internal implementation for SubscriptExpression
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Expr


/**
 *  A SubscriptExpression AST Node.
 */
class SubscriptExpressionImpl extends TSubscriptExpression, ExprImpl {
  private BICEP::SubscriptExpression ast;

  override string getAPrimaryQlClass() { result = "SubscriptExpression" }

  SubscriptExpressionImpl() { this = TSubscriptExpression(ast) }

  override string toString() { result = ast.toString() }



}