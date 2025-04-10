/**
 *  Internal implementation for UnaryExpression
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Expr


/**
 *  A UnaryExpression AST Node.
 */
class UnaryExpressionImpl extends TUnaryExpression, ExprImpl {
  private BICEP::UnaryExpression ast;

  override string getAPrimaryQlClass() { result = "UnaryExpression" }

  UnaryExpressionImpl() { this = TUnaryExpression(ast) }

  override string toString() { result = ast.toString() }



}