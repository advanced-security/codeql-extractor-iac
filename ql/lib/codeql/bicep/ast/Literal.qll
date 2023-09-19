import codeql.iac.ast.internal.Bicep
import codeql.bicep.ast.AstNodes

class Literal extends BicepAstNode, TLiteral {
  override string getAPrimaryQlClass() { result = "Literal" }

  string getValue() { none() }

  override string toString() { result = this.getValue() }
}

class NumberLiteral extends Literal, TNumber {
  private BICEP::Number literal;

  override string getAPrimaryQlClass() { result = "NumberLiteral" }

  NumberLiteral() { this = TNumber(literal) }
}

class NullLiteral extends Literal, TNull {
  private BICEP::Null literal;

  override string getAPrimaryQlClass() { result = "NullLiteral" }

  NullLiteral() { this = TNull(literal) }
}

class BooleanLiteral extends Literal, TBoolean {
  private BICEP::Boolean literal;

  override string getAPrimaryQlClass() { result = "BooleanLiteral" }

  BooleanLiteral() { this = TBoolean(literal) }
}

class StringLiteral extends Literal, TString {
  private BICEP::String literal;

  override string getAPrimaryQlClass() { result = "StringLiteral" }

  StringLiteral() { this = TString(literal) }
}
