/**
 * Internal: Control flow graph construction for Bicep.
 */

private import bicep
// CFG
import codeql.controlflow.Cfg
import Completion
private import Scope as Scope
private import codeql.bicep.controlflow.ControlFlowGraph as Cfg

// private import codeql.Locations
private module Implementation implements InputSig<Location> {
  private import bicep as Bicep
  private import Completion as C
  private import Splitting as S

  class AstNode = Bicep::AstNode;

  class Completion = C::Completion;

  predicate completionIsNormal = C::completionIsNormal/1;

  predicate completionIsSimple = C::completionIsSimple/1;

  predicate completionIsValidFor = C::completionIsValidFor/2;

  /** An AST node with an associated control-flow graph. */
  class CfgScope = Scope::CfgScope;

  class SplitKindBase = S::TSplitKind;

  class Split = S::Split;

  class SuccessorType = Cfg::SuccessorType;

  CfgScope getCfgScope(AstNode e) {
    exists(AstNode p | p = e.getParent() |
      result = p
      or
      not p instanceof CfgScope and result = getCfgScope(p)
    )
  }

  int maxSplits() { result = 0 }

  /** Holds if `first` is first executed when entering `scope`. */
  predicate scopeFirst(CfgScope scope, AstNode first) { scope.scopeFirst(first) }

 /** Holds if `scope` is exited when `last` finishes with completion `c`. */
  predicate scopeLast(CfgScope scope, AstNode last, Completion c) { scope.scopeLast(last, c) }

  predicate successorTypeIsSimple(SuccessorType t) { t instanceof Cfg::NormalSuccessor }

  predicate successorTypeIsCondition(SuccessorType t) { t instanceof Cfg::BooleanSuccessor }

  SuccessorType getAMatchingSuccessorType(Completion c) { result = c.getAMatchingSuccessorType() }

  predicate isAbnormalExitType(SuccessorType t) { none() }
}

private module CfgImpl = Make<Location, Implementation>;

import CfgImpl

/**
 * A literal value in a Bicep program.
 */
class LiteralTree extends LeafTree instanceof Literals { }
/**
 * A Interpolation literal value in a Bicep program.
 */
class InterpolationLiteralTree extends LeafTree instanceof InterpolationLiteral { }
/**
 * A Null literal value in a Bicep program.
 */
class NullLiteralTree extends LeafTree instanceof NullLiteral { }
/**
 * A NullableReturnType literal value in a Bicep program.
 */
class NullableReturnTypeLiteralTree extends LeafTree instanceof NullableReturnTypeLiteral { }
/**
 * A NullableType literal value in a Bicep program.
 */
class NullableTypeLiteralTree extends LeafTree instanceof NullableTypeLiteral { }
/**
 * A String literal value in a Bicep program.
 */
class StringLiteralTree extends LeafTree instanceof StringLiteral { }
/**
 * A StringContent literal value in a Bicep program.
 */
class StringContentLiteralTree extends LeafTree instanceof StringContentLiteral { }
