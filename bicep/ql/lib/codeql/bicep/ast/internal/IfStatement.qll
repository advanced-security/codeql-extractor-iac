/**
 *  Internal implementation for IfStatement
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Stmts


/**
 *  A IfStatement AST Node.
 */
class IfStatementImpl extends TIfStatement, StmtsImpl {
  private BICEP::IfStatement ast;

  override string getAPrimaryQlClass() { result = "IfStatement" }

  IfStatementImpl() { this = TIfStatement(ast) }

  override string toString() { result = ast.toString() }



}