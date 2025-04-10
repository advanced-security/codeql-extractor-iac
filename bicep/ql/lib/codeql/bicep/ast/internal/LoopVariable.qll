/**
 *  Internal implementation for LoopVariable
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A LoopVariable AST Node.
 */
class LoopVariableImpl extends TLoopVariable, AstNode {
  private BICEP::LoopVariable ast;

  override string getAPrimaryQlClass() { result = "LoopVariable" }

  LoopVariableImpl() { this = TLoopVariable(ast) }

  override string toString() { result = ast.toString() }



}