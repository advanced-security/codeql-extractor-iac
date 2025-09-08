/**
 * Classes and predicates for analyzing HCL literal values.
 * This includes string literals, numeric literals, boolean literals,
 * and null literals used in HCL configuration files.
 */

private import codeql.iac.ast.internal.Hcl
private import codeql.hcl.ast.AstNodes

/**
 * A literal value in HCL code.
 *
 * Literals represent constant values directly written in the code, such as
 * strings, numbers, booleans, and null values. They are the basic building
 * blocks for expressing concrete values in HCL configurations.
 *
 * Example HCL literals:
 * ```
 * resource "aws_instance" "example" {
 *   ami           = "ami-12345678"    // String literal
 *   instance_type = "t2.micro"       // String literal
 *   monitoring    = true             // Boolean literal
 *   count         = 2                // Numeric literal
 *   description   = null             // Null literal
 * }
 * ```
 */
class Literal extends Expr, TLiteral {
  @hcl_underscore_literal_value literal;

  override string getAPrimaryQlClass() { result = "Literal" }

  Literal() { literal = toHclTreeSitter(this) }

  /** Gets the string representation of this literal's value. */
  string getValue() { none() }

  override string toString() { result = this.getValue() }
}

/**
 * A string literal in HCL code.
 *
 * String literals represent textual values enclosed in double quotes.
 * They can contain escape sequences and interpolation expressions.
 *
 * Example HCL string literals:
 * ```
 * resource "aws_instance" "example" {
 *   ami             = "ami-12345678"              // Simple string literal
 *   name            = "web-server-${var.env}"    // String with interpolation
 *   description     = "A \"quoted\" description" // String with escape sequences
 * }
 * ```
 */
class StringLiteral extends Literal, TStringLit {
  override HCL::StringLit literal;

  override string getAPrimaryQlClass() { result = "StringLiteral" }

  StringLiteral() { this = TStringLit(literal) }

  /** Gets the string value of this literal, without the surrounding quotes. */
  override string getValue() { result = literal.getChild().getValue() }
}

/**
 * A numeric literal in HCL code.
 *
 * Numeric literals represent integer or floating-point numbers.
 * They can be written in decimal, hexadecimal, octal, or binary notation.
 *
 * Example HCL numeric literals:
 * ```
 * resource "aws_instance" "example" {
 *   count                = 3           // Integer literal
 *   cpu_credits          = 0.5         // Floating-point literal
 *   port                 = 0x50        // Hexadecimal literal
 *   allocated_storage    = 20          // Integer literal
 * }
 * ```
 */
class NumericLiteral extends Literal, TNumericLit {
  override HCL::NumericLit literal;

  override string getAPrimaryQlClass() { result = "NumericLiteral" }

  NumericLiteral() { this = TNumericLit(literal) }

  /** Gets the string representation of this numeric literal. */
  override string getValue() { result = literal.getValue() }

  /** Gets the integer value of this numeric literal, if it represents an integer. */
  int getInt() { result = literal.getValue().toInt() }
}

/**
 * A boolean literal in HCL code.
 *
 * Boolean literals represent true or false values.
 * They are used for flags, conditions, and binary configuration options.
 *
 * Example HCL boolean literals:
 * ```
 * resource "aws_instance" "example" {
 *   monitoring                = true      // Boolean literal (true)
 *   ebs_optimized            = false     // Boolean literal (false)
 *   associate_public_ip_address = true   // Boolean literal (true)
 * }
 * ```
 */
class BooleanLiteral extends Literal, TBooleanLiteral {
  override HCL::BoolLit literal;

  override string getAPrimaryQlClass() { result = "BooleanLiteral" }

  BooleanLiteral() { this = TBooleanLiteral(literal) }

  /** Gets the string representation of this boolean literal ("true" or "false"). */
  override string getValue() { result = literal.getValue() }

  /** Gets the boolean value of this literal. */
  boolean getBool() { result.toString() = literal.getValue() }
}

/**
 * A null literal in HCL code.
 *
 * Null literals represent the absence of a value. They are used to explicitly
 * indicate that an attribute should have no value or to reset a previously
 * defined value.
 *
 * Example HCL null literals:
 * ```
 * resource "aws_instance" "example" {
 *   key_name             = null          // Null literal - no key pair
 *   user_data           = null          // Null literal - no user data
 *   iam_instance_profile = null         // Null literal - no IAM profile
 * }
 * ```
 */
class NullLiteral extends Literal, TNullLiteral {
  override HCL::NullLit literal;

  override string getAPrimaryQlClass() { result = "NullLiteral" }

  NullLiteral() { this = TNullLiteral(literal) }

  /** Gets the string representation of this null literal ("null"). */
  override string getValue() { result = literal.getValue() }
}
