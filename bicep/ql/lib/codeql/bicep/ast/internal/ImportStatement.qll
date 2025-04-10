/**
 *  Internal implementation for ImportStatement
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Stmts


/**
 *  A ImportStatement AST Node.
 */
class ImportStatementImpl extends TImportStatement, StmtsImpl {
  private BICEP::ImportStatement ast;

  override string getAPrimaryQlClass() { result = "ImportStatement" }

  ImportStatementImpl() { this = TImportStatement(ast) }

  override string toString() { result = ast.toString() }



}