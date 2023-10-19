private import codeql.bicep.Ast
private import codeql.controlflow.Cfg as CfgShared
private import codeql.Locations

module Completion {
  private newtype TCompletion =
    TSimpleCompletion() or
    TBooleanCompletion(boolean b) { b in [false, true] } or
    TReturnCompletion()

  abstract class Completion extends TCompletion {
    abstract string toString();

    predicate isValidForSpecific(AstNode e) { none() }

    predicate isValidFor(AstNode e) { this.isValidForSpecific(e) }

    abstract SuccessorType getAMatchingSuccessorType();
  }

  abstract class NormalCompletion extends Completion { }

  class SimpleCompletion extends NormalCompletion, TSimpleCompletion {
    override string toString() { result = "SimpleCompletion" }

    override predicate isValidFor(AstNode e) { not any(Completion c).isValidForSpecific(e) }

    override NormalSuccessor getAMatchingSuccessorType() { any() }
  }

  class BooleanCompletion extends NormalCompletion, TBooleanCompletion {
    boolean value;

    BooleanCompletion() { this = TBooleanCompletion(value) }

    override string toString() { result = "BooleanCompletion(" + value + ")" }

    override predicate isValidForSpecific(AstNode e) { e = any(ForStatement c).getCondition() }

    override BooleanSuccessor getAMatchingSuccessorType() { result.getValue() = value }

    final boolean getValue() { result = value }
  }

  class ReturnCompletion extends Completion, TReturnCompletion {
    override string toString() { result = "ReturnCompletion" }

    override predicate isValidForSpecific(AstNode e) { none() }

    override ReturnSuccessor getAMatchingSuccessorType() { any() }
  }

  cached
  private newtype TSuccessorType =
    TNormalSuccessor() or
    TBooleanSuccessor(boolean b) { b in [false, true] } or
    TReturnSuccessor()

  class SuccessorType extends TSuccessorType {
    string toString() { none() }
  }

  class NormalSuccessor extends SuccessorType, TNormalSuccessor {
    override string toString() { result = "successor" }
  }

  class BooleanSuccessor extends SuccessorType, TBooleanSuccessor {
    boolean value;

    BooleanSuccessor() { this = TBooleanSuccessor(value) }

    override string toString() { result = value.toString() }

    boolean getValue() { result = value }
  }

  class ReturnSuccessor extends SuccessorType, TReturnSuccessor {
    override string toString() { result = "return" }
  }
}

module CfgScope {
  abstract class CfgScope extends AstNode { }

  private class InfrastructureScope extends CfgScope, Infrastructure { }
}

private module Implementation implements CfgShared::InputSig<Location> {
  import codeql.bicep.ast.Ast
  import Completion
  import CfgScope

  predicate completionIsNormal(Completion c) { not c instanceof ReturnCompletion }

  // Not using CFG splitting, so the following are just dummy types.
  private newtype TUnit = Unit()

  class SplitKindBase = TUnit;

  class Split extends TUnit {
    abstract string toString();
  }

  predicate completionIsSimple(Completion c) { c instanceof SimpleCompletion }

  predicate completionIsValidFor(Completion c, AstNode e) { c.isValidFor(e) }

  CfgScope getCfgScope(AstNode e) {
    exists(AstNode p | p = e.getParent() |
      result = p
      or
      not p instanceof CfgScope and result = getCfgScope(p)
    )
  }

  int maxSplits() { result = 0 }

  predicate scopeFirst(CfgScope scope, AstNode e) { first(scope.(Infrastructure), e) }

  predicate scopeLast(CfgScope scope, AstNode e, Completion c) {
    last(scope.(Infrastructure), e, c)
  }

  predicate successorTypeIsSimple(SuccessorType t) { t instanceof NormalSuccessor }

  predicate successorTypeIsCondition(SuccessorType t) { t instanceof BooleanSuccessor }

  SuccessorType getAMatchingSuccessorType(Completion c) { result = c.getAMatchingSuccessorType() }

  predicate isAbnormalExitType(SuccessorType t) { none() }
}

module CfgImpl = CfgShared::Make<Location, Implementation>;

private import CfgImpl
private import Completion
private import CfgScope

// Program / Infrastructure
private class InfrastructureTree extends StandardPreOrderTree instanceof Infrastructure {
  override ControlFlowTree getChildNode(int i) { result = super.getStatement(i) }
}

// Literals
private class NumberLiteralTree extends LeafTree, NumberLiteral { }

private class NullLiteralTree extends LeafTree, NullLiteral { }

private class BooleanLiteralTree extends LeafTree, BooleanLiteral { }

private class StringLiteralTree extends LeafTree, StringLiteral { }

private class StringContentTree extends LeafTree, StringContent { }

private class IdentifierTree extends LeafTree, Identifier { }

private class TypeTree extends LeafTree, Type { }

private class DecoratorTree extends LeafTree instanceof Decorator { }

private class DecoratorsTree extends StandardPreOrderTree, Decorators {
  override ControlFlowTree getChildNode(int i) { result = super.getDecorator(i) }
}

private class StmtTree extends StandardPreOrderTree, Stmt {
  override ControlFlowTree getChildNode(int i) { result = this.getChildNode(i) }
}

// Declarations
private class ResourceDeclarationTree extends StandardPreOrderTree, Resource {
  override ControlFlowTree getChildNode(int i) {
    result = this.getIdentifier() and i = 0
    or
    result = this.getBody() and i = 1
  }
}

// TODO(geekmasher): update
private class ObjectTree extends LeafTree, Object { }

// private class ObjectPropertyTree extends LeafTree, ObjectProperty { }
private class ParameterDeclarationTree extends StandardPreOrderTree, ParameterDeclaration {
  override ControlFlowTree getChildNode(int i) {
    result = this.getDefaultValue() and i = 0
    or
    result = this.getName() and i = 1
  }
}
