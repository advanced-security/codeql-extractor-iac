/**
 * @name Print AST
 * @description Produces a representation of a file's Abstract Syntax Tree.
 *              This query is used by the VS Code extension.
 * @id bicep/print-ast
 * @kind graph
 * @tags ide-contextual-queries/print-ast
 */

private import codeql.IDEContextual
private import codeql.bicep.AST
private import codeql.bicep.ideContextual.printAstAst

/**
 * The source file to generate an AST from.
 */
external string selectedSourceFile();

/**
 * A configuration that only prints nodes in the selected source file.
 */
class Cfg extends PrintAstConfiguration {
  override predicate shouldPrintNode(AstNode n) {
    super.shouldPrintNode(n) and
    n.getLocation().getFile() = getFileBySourceArchiveName(selectedSourceFile())
  }
}