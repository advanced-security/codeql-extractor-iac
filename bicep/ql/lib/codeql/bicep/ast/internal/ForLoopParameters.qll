/**
 *  Internal implementation for ForLoopParameters
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A ForLoopParameters AST Node.
 */
class ForLoopParametersImpl extends TForLoopParameters, AstNode {
  private BICEP::ForLoopParameters ast;

  override string getAPrimaryQlClass() { result = "ForLoopParameters" }

  ForLoopParametersImpl() { this = TForLoopParameters(ast) }

  override string toString() { result = ast.toString() }



}