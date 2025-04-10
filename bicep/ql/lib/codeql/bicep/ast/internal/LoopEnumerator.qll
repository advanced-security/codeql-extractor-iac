/**
 *  Internal implementation for LoopEnumerator
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A LoopEnumerator AST Node.
 */
class LoopEnumeratorImpl extends TLoopEnumerator, AstNode {
  private BICEP::LoopEnumerator ast;

  override string getAPrimaryQlClass() { result = "LoopEnumerator" }

  LoopEnumeratorImpl() { this = TLoopEnumerator(ast) }

  override string toString() { result = ast.toString() }



}