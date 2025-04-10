/**
 *  Internal implementation for Statement
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Stmts


/**
 *  A Statement AST Node.
 */
class StatementImpl extends TStatement, StmtsImpl {
  private BICEP::Statement ast;

  override string getAPrimaryQlClass() { result = "Statement" }

  StatementImpl() { this = TStatement(ast) }

  override string toString() { result = ast.toString() }



}