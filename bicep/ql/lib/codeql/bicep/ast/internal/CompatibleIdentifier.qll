/**
 *  Internal implementation for CompatibleIdentifier
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A CompatibleIdentifier AST Node.
 */
class CompatibleIdentifierImpl extends TCompatibleIdentifier, AstNode {
  private BICEP::CompatibleIdentifier ast;

  override string getAPrimaryQlClass() { result = "CompatibleIdentifier" }

  CompatibleIdentifierImpl() { this = TCompatibleIdentifier(ast) }

  override string toString() { result = ast.toString() }



}