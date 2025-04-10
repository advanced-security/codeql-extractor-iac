/**
 *  Internal implementation for Declaration
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A Declaration AST Node.
 */
class DeclarationImpl extends TDeclaration, AstNode {
  private BICEP::Declaration ast;

  override string getAPrimaryQlClass() { result = "Declaration" }

  DeclarationImpl() { this = TDeclaration(ast) }

  override string toString() { result = ast.toString() }



}