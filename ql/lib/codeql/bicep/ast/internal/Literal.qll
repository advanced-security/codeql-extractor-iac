private import codeql.iac.ast.internal.Bicep
private import codeql.bicep.ast.internal.AstNodes

class LiteralImpl extends BicepAstNode, TLiteral {
  override string getAPrimaryQlClass() { result = "Literal" }

  string getValue() { result = this.getValue() }

  override string toString() { result = this.getValue() }
}

/**
 * A Bicep literal number.
 */
class NumberLiteralImpl extends LiteralImpl, TNumber {
  private BICEP::Number literal;

  override string getAPrimaryQlClass() { result = "NumberLiteral" }

  NumberLiteralImpl() { this = TNumber(literal) }

  int getNumber() { result = literal.getValue().toInt() }
}

/**
 * A Bicep literal null.
 */
class NullLiteralImpl extends LiteralImpl, TNull {
  private BICEP::Null literal;

  override string getAPrimaryQlClass() { result = "NullLiteral" }

  NullLiteralImpl() { this = TNull(literal) }
}

/**
 * A Bicep literal boolean.
 */
class BooleanLiteralImpl extends LiteralImpl, TBoolean {
  private BICEP::Boolean literal;

  override string getAPrimaryQlClass() { result = "BooleanLiteral" }

  BooleanLiteralImpl() { this = TBoolean(literal) }

  boolean getBool() { result.toString() = literal.getValue() }
}

class StringLiteralImpl extends LiteralImpl, TString {
  private BICEP::String literal;

  override string getAPrimaryQlClass() { result = "StringLiteral" }

  StringLiteralImpl() { this = TString(literal) }

  override string getValue() {
    exists(StringContentImpl c | toBicepTreeSitter(c) = literal.getAFieldOrChild() |
      result = c.getValue()
    )
  }
}

/**
 * A Bicep literal string content.
 */
class StringContentImpl extends LiteralImpl, TStringContent {
  private BICEP::StringContent literal;

  override string getAPrimaryQlClass() { result = "StringContent" }

  StringContentImpl() { this = TStringContent(literal) }

  override string getValue() { result = literal.getValue() }
}
