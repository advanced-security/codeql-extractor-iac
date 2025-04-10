/**
 *  Internal implementation for Expression
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Expr


/**
 *  A Expression AST Node.
 */
class ExpressionImpl extends TExpression, ExprImpl {
  private BICEP::Expression ast;

  override string getAPrimaryQlClass() { result = "Expression" }

  ExpressionImpl() { this = TExpression(ast) }

  override string toString() { result = ast.toString() }



}