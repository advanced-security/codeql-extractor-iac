import codeql.iac.ast.internal.Bicep
import codeql.bicep.ast.AstNodes
import codeql.bicep.ast.Literal
import codeql.bicep.ast.Expr

class Object extends BicepAstNode, TObject {
  private BICEP::Object object;

  override string getAPrimaryQlClass() { result = "Object" }

  Object() { this = TObject(object) }

  ObjectProperty getProperties() { toBicepTreeSitter(result) = object.getAFieldOrChild() }

  Expr getProperty(string name) {
    exists(ObjectProperty prop | object.getAFieldOrChild() = toBicepTreeSitter(prop) |
      prop.getKey().(Identifier).getName() = name and
      result = prop.getValue()
    )
  }
}

class ObjectProperty extends BicepAstNode, TObjectProperty {
  private BICEP::ObjectProperty property;

  override string getAPrimaryQlClass() { result = "ObjectProperty" }

  ObjectProperty() { this = TObjectProperty(property) }

  override string toString() { result = this.getKey().getName() + " = " + this.getValue() }

  Identifier getKey() { toBicepTreeSitter(result) = property.getChild(0) }

  Expr getValue() { toBicepTreeSitter(result) = property.getChild(1) }
}
