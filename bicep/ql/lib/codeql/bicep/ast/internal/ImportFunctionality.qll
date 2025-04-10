/**
 *  Internal implementation for ImportFunctionality
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A ImportFunctionality AST Node.
 */
class ImportFunctionalityImpl extends TImportFunctionality, AstNode {
  private BICEP::ImportFunctionality ast;

  override string getAPrimaryQlClass() { result = "ImportFunctionality" }

  ImportFunctionalityImpl() { this = TImportFunctionality(ast) }

  override string toString() { result = ast.toString() }



}