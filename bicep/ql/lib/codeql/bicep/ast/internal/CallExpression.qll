/**
 *  Internal implementation for CallExpression
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Expr


/**
 *  A CallExpression AST Node.
 */
class CallExpressionImpl extends TCallExpression, ExprImpl {
  private BICEP::CallExpression ast;

  override string getAPrimaryQlClass() { result = "CallExpression" }

  CallExpressionImpl() { this = TCallExpression(ast) }

  override string toString() { result = ast.toString() }



}