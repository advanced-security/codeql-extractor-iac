/**
 *  Internal implementation for UsingStatement
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Stmts


/**
 *  A UsingStatement AST Node.
 */
class UsingStatementImpl extends TUsingStatement, StmtsImpl {
  private BICEP::UsingStatement ast;

  override string getAPrimaryQlClass() { result = "UsingStatement" }

  UsingStatementImpl() { this = TUsingStatement(ast) }

  override string toString() { result = ast.toString() }



}