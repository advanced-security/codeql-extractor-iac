/**
 *  Internal implementation for AssignmentExpression
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Expr


/**
 *  A AssignmentExpression AST Node.
 */
class AssignmentExpressionImpl extends TAssignmentExpression, ExprImpl {
  private BICEP::AssignmentExpression ast;

  override string getAPrimaryQlClass() { result = "AssignmentExpression" }

  AssignmentExpressionImpl() { this = TAssignmentExpression(ast) }

  override string toString() { result = ast.toString() }



}