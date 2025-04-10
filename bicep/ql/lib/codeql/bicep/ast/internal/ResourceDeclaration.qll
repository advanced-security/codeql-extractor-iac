/**
 *  Internal implementation for ResourceDeclaration
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A ResourceDeclaration AST Node.
 */
class ResourceDeclarationImpl extends TResourceDeclaration, AstNode {
  private BICEP::ResourceDeclaration ast;

  override string getAPrimaryQlClass() { result = "ResourceDeclaration" }

  ResourceDeclarationImpl() { this = TResourceDeclaration(ast) }

  override string toString() { result = ast.toString() }



}