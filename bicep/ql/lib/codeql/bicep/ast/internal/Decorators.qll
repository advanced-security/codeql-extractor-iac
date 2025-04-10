/**
 *  Internal implementation for Decorators
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A Decorators AST Node.
 */
class DecoratorsImpl extends TDecorators, AstNode {
  private BICEP::Decorators ast;

  override string getAPrimaryQlClass() { result = "Decorators" }

  DecoratorsImpl() { this = TDecorators(ast) }

  override string toString() { result = ast.toString() }



}