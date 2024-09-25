private import codeql.bicep.ast.internal.AstNodes
private import codeql.Locations

final class AstNode instanceof BicepAstNode {
  AstNode getAChild(string name) { result = super.getAChild(name) }

  AstNode getParent() { result.getAChild(_) = this }

  string toString() { result = super.toString() }

  string getAPrimaryQlClass() { result = super.getAPrimaryQlClass() }

  Location getLocation() { result = super.getLocation() }
}
