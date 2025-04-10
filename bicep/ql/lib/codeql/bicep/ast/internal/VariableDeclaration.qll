/**
 *  Internal implementation for VariableDeclaration
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A VariableDeclaration AST Node.
 */
class VariableDeclarationImpl extends TVariableDeclaration, AstNode {
  private BICEP::VariableDeclaration ast;

  override string getAPrimaryQlClass() { result = "VariableDeclaration" }

  VariableDeclarationImpl() { this = TVariableDeclaration(ast) }

  override string toString() { result = ast.toString() }



}