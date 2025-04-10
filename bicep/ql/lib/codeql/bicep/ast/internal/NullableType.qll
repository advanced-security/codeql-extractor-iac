/**
 *  Internal implementation for NullableType
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Expr


/**
 *  A NullableType AST Node.
 */
class NullableTypeImpl extends TNullableType, ExprImpl {
  private BICEP::NullableType ast;

  override string getAPrimaryQlClass() { result = "NullableType" }

  NullableTypeImpl() { this = TNullableType(ast) }

  override string toString() { result = ast.toString() }

}