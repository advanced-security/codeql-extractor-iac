private import codeql.iac.ast.internal.Bicep
private import codeql.bicep.ast.internal.AstNodes
private import codeql.bicep.ast.internal.Literal
private import codeql.bicep.ast.internal.Expr

class ObjectImpl extends ExprImpl, TObject {
  private BICEP::Object object;

  override string getAPrimaryQlClass() { result = "Object" }

  ObjectImpl() { this = TObject(object) }

  ObjectPropertyImpl getProperties() { toBicepTreeSitter(result) = object.getAFieldOrChild() }

  ExprImpl getProperty(string name) {
    exists(ObjectPropertyImpl prop | object.getAFieldOrChild() = toBicepTreeSitter(prop) |
      prop.getKey().(IdentifierImpl).getName() = name and
      result = prop.getValue()
    )
  }
}

class ObjectPropertyImpl extends BicepAstNode, TObjectProperty {
  private BICEP::ObjectProperty property;

  override string getAPrimaryQlClass() { result = "ObjectProperty" }

  ObjectPropertyImpl() { this = TObjectProperty(property) }

  override string toString() { result = this.getKey().getName() + " = " + this.getValue() }

  IdentifierImpl getKey() { toBicepTreeSitter(result) = property.getChild(0) }

  ExprImpl getValue() { toBicepTreeSitter(result) = property.getChild(1) }
}

class ArrayImpl extends ExprImpl, TArray {
  private BICEP::Array array;

  override string getAPrimaryQlClass() { result = "Array" }

  ArrayImpl() { this = TArray(array) }

  ExprImpl getElements() { toBicepTreeSitter(result) = array.getAFieldOrChild() }

  ExprImpl getElement(int index) { toBicepTreeSitter(result) = array.getChild(index) }
}
