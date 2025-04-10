/**
 *  Internal implementation for OutputDeclaration
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A OutputDeclaration AST Node.
 */
class OutputDeclarationImpl extends TOutputDeclaration, AstNode {
  private BICEP::OutputDeclaration ast;

  override string getAPrimaryQlClass() { result = "OutputDeclaration" }

  OutputDeclarationImpl() { this = TOutputDeclaration(ast) }

  override string toString() { result = ast.toString() }



}