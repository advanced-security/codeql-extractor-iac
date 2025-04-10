/**
 *  Internal implementation for AssertStatement
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Stmts


/**
 *  A AssertStatement AST Node.
 */
class AssertStatementImpl extends TAssertStatement, StmtsImpl {
  private BICEP::AssertStatement ast;

  override string getAPrimaryQlClass() { result = "AssertStatement" }

  AssertStatementImpl() { this = TAssertStatement(ast) }

  override string toString() { result = ast.toString() }



}