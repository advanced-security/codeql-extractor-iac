/**
 *  Internal implementation for PrimitiveType
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A PrimitiveType AST Node.
 */
class PrimitiveTypeImpl extends TPrimitiveType, AstNode {
  private BICEP::PrimitiveType ast;

  override string getAPrimaryQlClass() { result = "PrimitiveType" }

  PrimitiveTypeImpl() { this = TPrimitiveType(ast) }

  override string toString() { result = ast.toString() }



}