/**
 *  Internal implementation for Decorator
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A Decorator AST Node.
 */
class DecoratorImpl extends TDecorator, AstNode {
  private BICEP::Decorator ast;

  override string getAPrimaryQlClass() { result = "Decorator" }

  DecoratorImpl() { this = TDecorator(ast) }

  override string toString() { result = ast.toString() }



}