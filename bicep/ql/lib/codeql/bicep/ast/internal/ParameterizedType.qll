/**
 *  Internal implementation for ParameterizedType
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A ParameterizedType AST Node.
 */
class ParameterizedTypeImpl extends TParameterizedType, AstNode {
  private BICEP::ParameterizedType ast;

  override string getAPrimaryQlClass() { result = "ParameterizedType" }

  ParameterizedTypeImpl() { this = TParameterizedType(ast) }

  override string toString() { result = ast.toString() }



}