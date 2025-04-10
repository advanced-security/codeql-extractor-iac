/**
 *  Internal implementation for Arguments
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A Arguments AST Node.
 */
class ArgumentsImpl extends TArguments, AstNode {
  private BICEP::Arguments ast;

  override string getAPrimaryQlClass() { result = "Arguments" }

  ArgumentsImpl() { this = TArguments(ast) }

  override string toString() { result = ast.toString() }



}