private import codeql.bicep.ast.internal.AstNodes
private import codeql.bicep.ast.internal.Literal

final class Literal extends BicepAstNode instanceof LiteralImpl { }

final class NullLiteral extends Literal instanceof NullLiteralImpl { }

final class NumberLiteral extends Literal instanceof NumberLiteralImpl {
  int getNumber() { result = super.getNumber() }
}

final class BooleanLiteral extends Literal instanceof BooleanLiteralImpl {
  boolean getBool() { result = super.getBool() }
}

final class StringLiteral extends Literal instanceof StringLiteralImpl {
  string getValue() { result = super.getValue() }
}

final class StringContent extends Literal instanceof StringContentImpl {
  string getValue() { result = super.getValue() }
}
