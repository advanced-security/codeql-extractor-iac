/**
 *  Internal implementation for BinaryExpression
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Expr


/**
 *  A BinaryExpression AST Node.
 */
class BinaryExpressionImpl extends TBinaryExpression, ExprImpl {
  private BICEP::BinaryExpression ast;

  override string getAPrimaryQlClass() { result = "BinaryExpression" }

  BinaryExpressionImpl() { this = TBinaryExpression(ast) }

  override string toString() { result = ast.toString() }



}