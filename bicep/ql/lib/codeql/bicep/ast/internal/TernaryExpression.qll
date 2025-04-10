/**
 *  Internal implementation for TernaryExpression
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Expr


/**
 *  A TernaryExpression AST Node.
 */
class TernaryExpressionImpl extends TTernaryExpression, ExprImpl {
  private BICEP::TernaryExpression ast;

  override string getAPrimaryQlClass() { result = "TernaryExpression" }

  TernaryExpressionImpl() { this = TTernaryExpression(ast) }

  override string toString() { result = ast.toString() }



}