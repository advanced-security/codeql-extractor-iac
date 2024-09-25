private import codeql.bicep.ast.Ast
private import codeql.bicep.ast.internal.Object
private import codeql.bicep.ast.Expr

/**
 * A Bicep Object.
 */
final class Object extends AstNode instanceof ObjectImpl {
  ObjectProperty getProperties() { result = super.getProperties() }

  Expr getProperty(string name) { result = super.getProperty(name) }
}

/**
 * A Bicep Object property.
 */
final class ObjectProperty extends AstNode instanceof ObjectPropertyImpl {
  Identifier getKey() { result = super.getKey() }

  Expr getValue() { result = super.getValue() }
}

/**
 * A Bicep Array.
 */
final class Array extends Expr instanceof ArrayImpl {
  Expr getElements() { result = super.getElements() }

  Expr getElement(int index) { result = super.getElement(index) }
}
