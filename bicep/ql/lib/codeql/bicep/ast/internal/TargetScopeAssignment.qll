/**
 *  Internal implementation for TargetScopeAssignment
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A TargetScopeAssignment AST Node.
 */
class TargetScopeAssignmentImpl extends TTargetScopeAssignment, AstNode {
  private BICEP::TargetScopeAssignment ast;

  override string getAPrimaryQlClass() { result = "TargetScopeAssignment" }

  TargetScopeAssignmentImpl() { this = TTargetScopeAssignment(ast) }

  override string toString() { result = ast.toString() }



}