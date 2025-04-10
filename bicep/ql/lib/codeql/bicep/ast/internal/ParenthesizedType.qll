/**
 *  Internal implementation for ParenthesizedType
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A ParenthesizedType AST Node.
 */
class ParenthesizedTypeImpl extends TParenthesizedType, AstNode {
  private BICEP::ParenthesizedType ast;

  override string getAPrimaryQlClass() { result = "ParenthesizedType" }

  ParenthesizedTypeImpl() { this = TParenthesizedType(ast) }

  override string toString() { result = ast.toString() }



}