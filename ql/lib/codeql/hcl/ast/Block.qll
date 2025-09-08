/**
 * Classes and predicates for analyzing HCL block structures.
 * Blocks are the primary organizational unit in HCL, representing resources,
 * data sources, variables, outputs, and other configuration elements.
 */

private import codeql.Locations
private import codeql.files.FileSystem
private import codeql.iac.ast.internal.Hcl
private import codeql.hcl.ast.AstNodes
private import codeql.hcl.ast.Attributes

/**
 * A block in HCL code.
 *
 * Blocks are the fundamental structural elements in HCL configuration files.
 * They define resources, data sources, variables, outputs, and other configuration
 * components. Blocks have a type, optional labels, and a body containing attributes
 * and nested blocks.
 *
 * Example HCL blocks:
 * ```
 * resource "aws_instance" "web" {     // Block type: "resource", Labels: ["aws_instance", "web"]
 *   ami           = "ami-12345678"
 *   instance_type = "t2.micro"
 *
 *   tags = {
 *     Name = "WebServer"
 *   }
 * }
 *
 * variable "environment" {            // Block type: "variable", Labels: ["environment"]
 *   description = "The deployment environment"
 *   type        = string
 *   default     = "dev"
 * }
 * ```
 */
class Block extends Expr, TBlock {
  HCL::Block block;

  override string getAPrimaryQlClass() { result = "Block" }

  Block() { this = TBlock(block) }

  /** Gets the type of this block (e.g., "resource", "variable", "data"). */
  string getType() { result = block.getType().getValue() }

  /** Holds if this block has the specified type. */
  predicate hasType(string type) { type = this.getType() }

  override string toString() { result = this.getType() }

  /** Gets any nested block within this block's body. */
  Block getABlock() { toHclTreeSitter(result) = block.getBody().getChild(_) }

  /**
   * Gets the label at the specified index.
   *
   * Labels provide additional identification for blocks. For example,
   * in `resource "aws_instance" "web"`, the labels are "aws_instance" and "web".
   */
  string getLabel(int i) {
    result = block.getLabel(i).(HCL::Identifier).getValue() or
    result = block.getLabel(i).(HCL::StringLit).getChild().getValue()
  }

  /** Holds if this block has the specified label at the given index. */
  predicate hasLabel(int i, string label) { label = this.getLabel(i) }

  override HclAstNode getAChild(string pred) {
    pred = "getABlock" and result = this.getABlock()
    or
    pred = "getAttribute" and result = this.getAttribute(_)
  }

  /**
   * Gets the value of an attribute or nested block with the specified name.
   *
   * This predicate can return either attribute values or nested blocks
   * that match the given name.
   */
  Expr getAttribute(string name) {
    exists(Attribute attr | block.getBody().getChild(_) = toHclTreeSitter(attr) |
      attr.getKey().(Identifier).getName() = name and
      result = attr.getExpr()
    )
    or
    result = this.getABlock() and result.(Block).hasType(name)
  }

  /** Gets any attribute defined in this block's body. */
  Attribute getAttributes() { toHclTreeSitter(result) = block.getBody().getChild(_) }

  /** Holds if this block has an attribute with the specified name. */
  predicate hasAttribute(string name) {
    exists(Attribute attr | block.getBody().getChild(_) = toHclTreeSitter(attr) |
      attr.getKey().(Identifier).getName() = name
    )
  }

  /**
   * Gets the identifier that serves as the key for the given attribute expression.
   *
   * This is useful for reverse lookups to find which attribute name
   * corresponds to a particular expression value.
   */
  Identifier getAttributeName(Expr expr) {
    exists(Attribute attr | attr = this.getAttributes() |
      attr.getExpr() = expr and
      result = attr.getKey()
    )
  }
}
