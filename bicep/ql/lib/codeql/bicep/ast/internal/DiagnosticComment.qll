/**
 *  Internal implementation for DiagnosticComment
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A DiagnosticComment AST Node.
 */
class DiagnosticCommentImpl extends TDiagnosticComment, AstNode {
  private BICEP::DiagnosticComment ast;

  override string getAPrimaryQlClass() { result = "DiagnosticComment" }

  DiagnosticCommentImpl() { this = TDiagnosticComment(ast) }

  override string toString() { result = ast.toString() }



}