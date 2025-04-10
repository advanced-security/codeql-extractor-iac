/**
 *  Internal implementation for ResourceExpression
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Expr


/**
 *  A ResourceExpression AST Node.
 */
class ResourceExpressionImpl extends TResourceExpression, ExprImpl {
  private BICEP::ResourceExpression ast;

  override string getAPrimaryQlClass() { result = "ResourceExpression" }

  ResourceExpressionImpl() { this = TResourceExpression(ast) }

  override string toString() { result = ast.toString() }



}