/**
 *  Internal implementation for ImportWithStatement
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Stmts


/**
 *  A ImportWithStatement AST Node.
 */
class ImportWithStatementImpl extends TImportWithStatement, StmtsImpl {
  private BICEP::ImportWithStatement ast;

  override string getAPrimaryQlClass() { result = "ImportWithStatement" }

  ImportWithStatementImpl() { this = TImportWithStatement(ast) }

  override string toString() { result = ast.toString() }



}