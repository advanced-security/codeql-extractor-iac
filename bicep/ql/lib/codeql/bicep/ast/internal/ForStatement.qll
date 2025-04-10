/**
 *  Internal implementation for ForStatement
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Stmts


/**
 *  A ForStatement AST Node.
 */
class ForStatementImpl extends TForStatement, StmtsImpl {
  private BICEP::ForStatement ast;

  override string getAPrimaryQlClass() { result = "ForStatement" }

  ForStatementImpl() { this = TForStatement(ast) }

  override string toString() { result = ast.toString() }



}