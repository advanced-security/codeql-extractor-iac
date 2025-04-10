/**
 *  Internal implementation for ParameterDeclaration
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A ParameterDeclaration AST Node.
 */
class ParameterDeclarationImpl extends TParameterDeclaration, AstNode {
  private BICEP::ParameterDeclaration ast;

  override string getAPrimaryQlClass() { result = "ParameterDeclaration" }

  ParameterDeclarationImpl() { this = TParameterDeclaration(ast) }

  override string toString() { result = ast.toString() }



}