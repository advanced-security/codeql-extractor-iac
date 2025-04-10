/**
 *  Internal implementation for ModuleDeclaration
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A ModuleDeclaration AST Node.
 */
class ModuleDeclarationImpl extends TModuleDeclaration, AstNode {
  private BICEP::ModuleDeclaration ast;

  override string getAPrimaryQlClass() { result = "ModuleDeclaration" }

  ModuleDeclarationImpl() { this = TModuleDeclaration(ast) }

  override string toString() { result = ast.toString() }



}