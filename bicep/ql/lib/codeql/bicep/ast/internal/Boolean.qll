/**
 *  Internal implementation for Boolean
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A Boolean AST Node.
 */
class BooleanImpl extends TBoolean, AstNode {
  private BICEP::Boolean ast;

  override string getAPrimaryQlClass() { result = "Boolean" }

  BooleanImpl() { this = TBoolean(ast) }

  override string toString() { result = ast.toString() }



}