/**
 *  Internal implementation for EscapeSequence
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A EscapeSequence AST Node.
 */
class EscapeSequenceImpl extends TEscapeSequence, AstNode {
  private BICEP::EscapeSequence ast;

  override string getAPrimaryQlClass() { result = "EscapeSequence" }

  EscapeSequenceImpl() { this = TEscapeSequence(ast) }

  override string toString() { result = ast.toString() }



}