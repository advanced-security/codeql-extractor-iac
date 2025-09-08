/**
 * Base classes and core AST node implementations for HCL (HashiCorp Configuration Language).
 * This module defines the fundamental AST node types including expressions, identifiers, objects,
 * binary operations, and other core language constructs.
 */

private import codeql.Locations
private import codeql.files.FileSystem
private import codeql.iac.ast.internal.Hcl
private import codeql.hcl.ast.Literals
private import codeql.hcl.ast.Variables

/**
 * An AST node of an HCL program.
 *
 * HCL AST nodes represent the structure of HashiCorp Configuration Language code,
 * including all expressions, statements, blocks, and other language constructs.
 *
 * Example HCL code:
 * ```hcl
 * resource "aws_instance" "example" {
 *   ami           = "ami-12345678"
 *   instance_type = "t2.micro"
 * }
 * ```
 */
class HclAstNode extends THclAstNode {
  string toString() { result = this.getAPrimaryQlClass() }

  /** Gets the location of the AST node. */
  cached
  Location getLocation() { result = this.getFullLocation() } // overridden in some subclasses

  /** Gets the file containing this AST node. */
  cached
  File getFile() { result = this.getFullLocation().getFile() }

  /** Gets the location that spans the entire AST node. */
  cached
  final Location getFullLocation() { result = toHclTreeSitter(this).getLocation() }

  predicate hasLocationInfo(
    string filepath, int startline, int startcolumn, int endline, int endcolumn
  ) {
    if exists(this.getLocation())
    then this.getLocation().hasLocationInfo(filepath, startline, startcolumn, endline, endcolumn)
    else (
      filepath = "" and
      startline = 0 and
      startcolumn = 0 and
      endline = 0 and
      endcolumn = 0
    )
  }

  /**
   * Gets the parent in the AST for this node.
   *
   * Returns the parent AST node that contains this node as a child.
   */
  cached
  HclAstNode getParent() { result.getAChild(_) = this }

  /**
   * Gets a child of this node, which can also be retrieved using a predicate
   * named `pred`.
   *
   * For example, for a binary operation, this might return the left and right operands
   * with predicates "getLeftOperand" and "getRightOperand".
   */
  cached
  HclAstNode getAChild(string pred) { none() }

  /**
   * Gets any child of this node.
   *
   * This is a convenience predicate that returns all children regardless of their predicate name.
   */
  HclAstNode getAChild() { result = this.getAChild(_) }

  /**
   * Gets the primary QL class for the AST node.
   *
   * This is used for identification and debugging purposes.
   */
  string getAPrimaryQlClass() { result = "???" }
}

/**
 * A comment in HCL code.
 *
 * Comments are used for documentation and annotations in HCL files.
 * They can be single-line or multi-line comments.
 *
 * Example HCL code:
 * ```
 * // This is a single-line comment
 * resource "aws_instance" "example" {
 *   ami = "ami-12345678"
 * }
 * ```
 */
class Comment extends HclAstNode, TComment {
  private HCL::Comment comment;

  override string getAPrimaryQlClass() { result = "Comment" }

  Comment() { this = TComment(comment) }

  /** Gets the textual contents of the comment. */
  string getContents() { result = comment.getValue() }
}

/**
 * An expression in HCL code.
 *
 * Expressions represent values and computations in HCL, including literals,
 * variables, function calls, binary operations, and complex data structures.
 *
 * Example HCL expressions:
 * ```
 * resource "aws_instance" "example" {
 *   ami           = "ami-12345678"        // String literal expression
 *   instance_type = var.instance_type     // Variable expression
 *   count         = length(var.subnets)   // Function call expression
 *   enabled       = true && var.enabled  // Binary operation expression
 * }
 * ```
 */
class Expr extends HclAstNode, TExpr {
  override string getAPrimaryQlClass() { result = "Expr" }
}

/**
 * A binary operation expression in HCL.
 *
 * Binary operations combine two expressions with an operator such as +, -, *, /,
 * ==, !=, &&, ||, etc.
 *
 * Example HCL binary operations:
 * ```
 * locals {
 *   sum = var.a + var.b           // Addition
 *   enabled = var.debug && true   // Logical AND
 *   equal = var.env == "prod"     // Equality comparison
 * }
 * ```
 */
class BinaryOperation extends Expr {
  HCL::BinaryOperation binaryOp;

  override string getAPrimaryQlClass() { result = "BinaryOperation" }

  BinaryOperation() { this = TBinaryOperation(binaryOp) }

  /** Gets the left operand of the binary operation. */
  Expr getLeftOperand() { toHclTreeSitter(result) = binaryOp.getLeft() }

  /** Gets the right operand of the binary operation. */
  Expr getRightOperand() { toHclTreeSitter(result) = binaryOp.getRight() }

  /** Gets the operator string (e.g., "+", "&&", "=="). */
  string getOperator() { result = binaryOp.getOperator() }

  override string toString() {
    result = this.getLeftOperand() + " " + this.getOperator() + " " + this.getRightOperand()
  }

  override HclAstNode getAChild(string pred) {
    pred = "getLeftOperand" and result = this.getLeftOperand()
    or
    pred = "getRightOperand" and result = this.getRightOperand()
  }
}

/**
 * An identifier in HCL code.
 *
 * Identifiers represent names of variables, attributes, functions, and other named entities.
 * They must follow HCL naming conventions (alphanumeric characters and underscores).
 *
 * Example HCL identifiers:
 * ```
 * resource "aws_instance" "web_server" {
 *   ami           = var.instance_ami    // 'ami', 'var', 'instance_ami' are identifiers
 *   instance_type = "t2.micro"
 *   tags = {
 *     Name        = "WebServer"         // 'Name' is an identifier
 *     Environment = var.environment     // 'Environment', 'environment' are identifiers
 *   }
 * }
 * ```
 */
class Identifier extends Expr, TIdentifier {
  private HCL::Identifier identifier;

  override string getAPrimaryQlClass() { result = "Identifier" }

  Identifier() { this = TIdentifier(identifier) }

  /** Gets the name of the identifier. */
  string getName() { result = identifier.getValue() }
}

/**
 * An object expression in HCL.
 *
 * Objects are collections of key-value pairs enclosed in curly braces.
 * They represent structured data similar to maps or dictionaries in other languages.
 *
 * Example HCL objects:
 * ```
 * resource "aws_instance" "example" {
 *   tags = {                    // This is an object
 *     Name        = "WebServer"
 *     Environment = "production"
 *     Owner       = var.team_name
 *   }
 * }
 * ```
 */
class Object extends Expr, TObject {
  private HCL::Object object;

  override string getAPrimaryQlClass() { result = "Object" }

  Object() { this = TObject(object) }

  /** Gets the object element at the specified index. */
  ObjectElement getElement(int index) { toHclTreeSitter(result) = object.getElement(index) }

  /** Gets any object element in this object. */
  ObjectElement getElements() { toHclTreeSitter(result) = object.getElement(_) }

  /**
   * Gets the value expression for an element with the specified key name.
   *
   * This predicate handles both identifier keys and string literal keys.
   */
  Expr getElementByName(string name) {
    exists(ObjectElement elem | this.getElements() = elem |
      (
        // Variable / Identifier
        elem.getKey().(Variable).getName() = name
        or
        // StringLiteral
        elem.getKey().(StringLiteral).getValue() = name
      ) and
      result = elem.getExpr()
    )
  }
}

/**
 * An object element (key-value pair) in HCL.
 *
 * Object elements represent individual key-value pairs within an object.
 * The key can be an identifier, string literal, or expression, and the value
 * can be any valid HCL expression.
 *
 * Example HCL object elements:
 * ```
 * tags = {
 *   Name        = "WebServer"     // ObjectElement with identifier key
 *   "Team-Name" = var.team        // ObjectElement with string literal key
 * }
 * ```
 */
class ObjectElement extends Expr, TObjectElem {
  private HCL::ObjectElem objectElem;

  override string getAPrimaryQlClass() { result = "ObjectElement" }

  ObjectElement() { this = TObjectElem(objectElem) }

  /** Gets the key expression of this object element. */
  Expr getKey() { toHclTreeSitter(result) = objectElem.getKey() }

  /** Gets the value expression of this object element. */
  Expr getExpr() { toHclTreeSitter(result) = objectElem.getVal() }
}

/**
 * A tuple expression in HCL.
 *
 * Tuples are ordered collections of expressions enclosed in square brackets.
 * They represent lists or arrays of values.
 *
 * Example HCL tuples:
 * ```
 * resource "aws_security_group" "example" {
 *   ingress {
 *     cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12"]  // This is a tuple
 *   }
 * }
 * ```
 */
class Tuple extends Expr, TTuple {
  private HCL::Tuple tuple;

  override string getAPrimaryQlClass() { result = "Tuple" }

  Tuple() { this = TTuple(tuple) }

  /** Gets the element at the specified index in the tuple. */
  Expr getElement(int i) { toHclTreeSitter(result) = tuple.getElement(i) }
}

/**
 * A heredoc template expression in HCL.
 *
 * Heredocs allow multi-line string literals with embedded expressions.
 * They are useful for defining large text blocks or templates.
 *
 * Example HCL heredoc:
 * ```
 * resource "aws_instance" "example" {
 *   user_data = <<-EOF
 *     #!/bin/bash
 *     echo "Hello, ${var.name}!"
 *   EOF
 * }
 * ```
 */
class HereDoc extends Expr, THeredocTemplate {
  private HCL::HeredocTemplate hereDoc;

  HereDoc() { this = THeredocTemplate(hereDoc) }
}
