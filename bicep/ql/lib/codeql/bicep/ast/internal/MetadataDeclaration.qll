/**
 *  Internal implementation for MetadataDeclaration
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A MetadataDeclaration AST Node.
 */
class MetadataDeclarationImpl extends TMetadataDeclaration, AstNode {
  private BICEP::MetadataDeclaration ast;

  override string getAPrimaryQlClass() { result = "MetadataDeclaration" }

  MetadataDeclarationImpl() { this = TMetadataDeclaration(ast) }

  override string toString() { result = ast.toString() }



}