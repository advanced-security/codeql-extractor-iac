/**
 *  Internal implementation for TypeDeclaration
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A TypeDeclaration AST Node.
 */
class TypeDeclarationImpl extends TTypeDeclaration, AstNode {
  private BICEP::TypeDeclaration ast;

  override string getAPrimaryQlClass() { result = "TypeDeclaration" }

  TypeDeclarationImpl() { this = TTypeDeclaration(ast) }

  override string toString() { result = ast.toString() }



}