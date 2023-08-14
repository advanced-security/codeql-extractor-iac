/**
 * @name Print AST
 * @description Produces a representation of a file's Abstract Syntax Tree.
 *              This query is used by the VS Code extension.
 * @id iac/print-ast
 * @kind graph
 * @tags ide-contextual-queries/print-ast
 */

// Switch between these imports to switch between viewing the internal AST or the user-facing AST layer
import codeql.iac.ideContextual.printAstGenerated
//import codeql.iac.ideContextual.printAstAst
import codeql.iac.ideContextual.IDEContextual

/**
 * Gets the source file to generate an AST from.
 */
external string selectedSourceFile();

// Overrides the configuration to print only nodes in the selected source file.
class Cfg extends PrintAstConfiguration {
  override predicate shouldPrintNode(AstNode n) {
    super.shouldPrintNode(n) and
    n.getLocation().getFile() = getFileBySourceArchiveName(selectedSourceFile())
  }
}
