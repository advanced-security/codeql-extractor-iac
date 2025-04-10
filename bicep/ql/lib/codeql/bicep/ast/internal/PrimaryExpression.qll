/**
 *  Internal implementation for PrimaryExpression
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Expr


/**
 *  A PrimaryExpression AST Node.
 */
class PrimaryExpressionImpl extends TPrimaryExpression, ExprImpl {
  private BICEP::PrimaryExpression ast;

  override string getAPrimaryQlClass() { result = "PrimaryExpression" }

  PrimaryExpressionImpl() { this = TPrimaryExpression(ast) }

  override string toString() { result = ast.toString() }



}