private import codeql.bicep.ast.AstNodes
private import AstNodes
private import TreeSitter
private import Expr

/**
 * Generic statement implementation class.
 */
class StmtsImpl extends AstNode, TStmts {
  override string getAPrimaryQlClass() { result = "Stmts" }
}
