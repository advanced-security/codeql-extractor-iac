/**
 * Statement nodes in the AST.
 */
private import AstNodes
private import internal.AstNodes
private import internal.TreeSitter
private import internal.Stmts
private import internal.AssertStatement
private import internal.ForStatement
private import internal.IfStatement
private import internal.ImportStatement
private import internal.ImportWithStatement
private import internal.Statement
private import internal.UsingStatement
// CFG
private import codeql.bicep.CFG
private import codeql.bicep.controlflow.internal.ControlFlowGraphImpl as CfgImpl

/**
 * A Stmt block
 */
class Stmts extends AstNode instanceof StmtsImpl {
  /** Gets a control-flow node for this statement, if any. */
  CfgImpl::AstCfgNode getAControlFlowNode() { result.getAstNode() = this }
  
  /** Gets a control-flow entry node for this statement, if any */
  AstNode getAControlFlowEntryNode() { result = CfgImpl::getAControlFlowEntryNode(this) }
}



/**
 * A AssertStatement statement
 */
final class AssertStatementStmt extends Stmts instanceof AssertStatementImpl { }
/**
 * A ForStatement statement
 */
final class ForStatementStmt extends Stmts instanceof ForStatementImpl { }
/**
 * A IfStatement statement
 */
final class IfStatementStmt extends Stmts instanceof IfStatementImpl { }
/**
 * A ImportStatement statement
 */
final class ImportStatementStmt extends Stmts instanceof ImportStatementImpl { }
/**
 * A ImportWithStatement statement
 */
final class ImportWithStatementStmt extends Stmts instanceof ImportWithStatementImpl { }
/**
 * A Statement statement
 */
final class StatementStmt extends Stmts instanceof StatementImpl { }
/**
 * A UsingStatement statement
 */
final class UsingStatementStmt extends Stmts instanceof UsingStatementImpl { }
