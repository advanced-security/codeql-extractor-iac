private import codeql.util.Boolean
private import codeql.bicep.controlflow.ControlFlowGraph
private import bicep
private import SuccessorType

newtype TCompletion =
  TSimpleCompletion() or
  TBooleanCompletion(Boolean b) or
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

/**
 * A completion that represents evaluation of an expression, whose value
 * determines the successor.
 */
abstract class ConditionalCompletion extends NormalCompletion {
  boolean value;

  bindingset[value]
  ConditionalCompletion() { any() }

  /** Gets the Boolean value of this conditional completion. */
  final boolean getValue() { result = value }

  final predicate succeeded() { value = true }

  final predicate failed() { value = false }

  /** Gets the dual completion. */
  abstract ConditionalCompletion getDual();
}

class BooleanCompletion extends ConditionalCompletion, TBooleanCompletion {
  BooleanCompletion() { this = TBooleanCompletion(value) }

  override string toString() { result = "boolean(" + value + ")" }

  /**
   * Implements valid completions for expressions.
   * 
   * TODO: This is a placeholder implementation.
   */
  override predicate isValidForSpecific(AstNode e) {
    // Example:
    //   e = any(ForLoop c).getCondition()
    none()
  }

  /** Gets the dual Boolean completion. */
  override BooleanCompletion getDual() { result = TBooleanCompletion(value.booleanNot()) }

  override BooleanSuccessor getAMatchingSuccessorType() { result.getValue() = value }

  final boolean getValue() { result = value }
}

class ReturnCompletion extends Completion, TReturnCompletion {
  override string toString() { result = "ReturnCompletion" }

  override predicate isValidForSpecific(AstNode e) { none() }

  override ReturnSuccessor getAMatchingSuccessorType() { any() }
}

/** Hold if `c` represents normal evaluation of a statement or an expression. */
predicate completionIsNormal(Completion c) { c instanceof NormalCompletion }

/** Hold if `c` represents simple and normal evaluation of a statement or an expression. */
predicate completionIsSimple(Completion c) { c instanceof SimpleCompletion }

/** Holds if `c` is a valid completion for `n`. */
predicate completionIsValidFor(Completion c, AstNode n) { c.isValidFor(n) }
