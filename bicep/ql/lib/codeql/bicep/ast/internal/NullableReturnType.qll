/**
 *  Internal implementation for NullableReturnType
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Literals


/**
 *  A NullableReturnType AST Node.
 */
class NullableReturnTypeImpl extends TNullableReturnType, LiteralsImpl {
  private BICEP::NullableReturnType ast;

  override string getAPrimaryQlClass() { result = "NullableReturnType" }

  NullableReturnTypeImpl() { this = TNullableReturnType(ast) }

  override string toString() { result = ast.toString() }
  /**
   *  Get the literal value
   */
  override string getValue() { result = ast.getValue() }



}