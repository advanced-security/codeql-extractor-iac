/**
 *  Internal implementation for Interpolation
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Expr


/**
 *  A Interpolation AST Node.
 */
class InterpolationImpl extends TInterpolation, ExprImpl {
  private BICEP::Interpolation ast;

  override string getAPrimaryQlClass() { result = "Interpolation" }

  InterpolationImpl() { this = TInterpolation(ast) }

  override string toString() { result = ast.toString() }

}