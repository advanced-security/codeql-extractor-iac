/**
 *  Internal implementation for NegatedType
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A NegatedType AST Node.
 */
class NegatedTypeImpl extends TNegatedType, AstNode {
  private BICEP::NegatedType ast;

  override string getAPrimaryQlClass() { result = "NegatedType" }

  NegatedTypeImpl() { this = TNegatedType(ast) }

  override string toString() { result = ast.toString() }



}