private import codeql.iac.ast.internal.Hcl
private import codeql.hcl.ast.AstNodes

class Literal extends Expr, TLiteral {
  @hcl_underscore_literal_value literal;

  override string getAPrimaryQlClass() { result = "Literal" }

  Literal() { literal = toHclTreeSitter(this) }

  string getValue() { none() }

  override string toString() { result = this.getValue() }
}

class StringLiteral extends Literal, TStringLit {
  override HCL::StringLit literal;

  override string getAPrimaryQlClass() { result = "StringLiteral" }

  StringLiteral() { this = TStringLit(literal) }

  override string getValue() { result = literal.getChild().getValue() }
}

class NumericLiteral extends Literal, TNumericLit {
  override HCL::NumericLit literal;

  override string getAPrimaryQlClass() { result = "NumericLiteral" }

  NumericLiteral() { this = TNumericLit(literal) }

  override string getValue() { result = literal.getValue() }
}

class BooleanLiteral extends Literal, TBooleanLiteral {
  override HCL::BoolLit literal;

  override string getAPrimaryQlClass() { result = "BooleanLiteral" }

  BooleanLiteral() { this = TBooleanLiteral(literal) }

  override string getValue() { result = literal.getValue() }

  boolean getBool() { result.toString() = literal.getValue() }
}

class NullLiteral extends Literal, TNullLiteral {
  override HCL::NullLit literal;

  override string getAPrimaryQlClass() { result = "NullLiteral" }

  NullLiteral() { this = TNullLiteral(literal) }

  override string getValue() { result = literal.getValue() }
}
