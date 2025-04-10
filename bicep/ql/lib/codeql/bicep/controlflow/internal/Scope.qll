private import bicep
private import codeql.bicep.AST
private import Completion
private import ControlFlowGraphImpl

abstract class CfgScope extends AstNode {
  /** Holds if `first` is executed first when entering scope. */
  abstract predicate scopeFirst(AstNode first);

  /** Holds if scope is exited when `last` finishes with completion `c`. */
  abstract predicate scopeLast(AstNode last, Completion c);
}
