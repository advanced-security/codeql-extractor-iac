/**
 *  Internal implementation for PropertyIdentifier
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A PropertyIdentifier AST Node.
 */
class PropertyIdentifierImpl extends TPropertyIdentifier, AstNode {
  private BICEP::PropertyIdentifier ast;

  override string getAPrimaryQlClass() { result = "PropertyIdentifier" }

  PropertyIdentifierImpl() { this = TPropertyIdentifier(ast) }

  override string toString() { result = ast.toString() }



}