/**
 *  Internal implementation for ReservedWord
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A ReservedWord AST Node.
 */
class ReservedWordImpl extends TReservedWord, AstNode {
  private BICEP::ReservedWord ast;

  override string getAPrimaryQlClass() { result = "ReservedWord" }

  ReservedWordImpl() { this = TReservedWord(ast) }

  override string toString() { result = ast.toString() }



}