/**
 *  Internal implementation for TypeArguments
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A TypeArguments AST Node.
 */
class TypeArgumentsImpl extends TTypeArguments, AstNode {
  private BICEP::TypeArguments ast;

  override string getAPrimaryQlClass() { result = "TypeArguments" }

  TypeArgumentsImpl() { this = TTypeArguments(ast) }

  override string toString() { result = ast.toString() }



}