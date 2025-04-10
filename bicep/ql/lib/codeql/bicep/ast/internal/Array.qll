/**
 *  Internal implementation for Array
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A Array AST Node.
 */
class ArrayImpl extends TArray, AstNode {
  private BICEP::Array ast;

  override string getAPrimaryQlClass() { result = "Array" }

  ArrayImpl() { this = TArray(ast) }

  override string toString() { result = ast.toString() }



}