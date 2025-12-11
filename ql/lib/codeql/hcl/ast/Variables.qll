/**
 * Classes and predicates for analyzing HCL variable expressions and attribute access expressions.
 * This includes variable references, attribute access (dot notation), and property lookups.
 */

private import codeql.Locations
private import codeql.files.FileSystem
private import codeql.iac.ast.internal.Hcl
private import codeql.hcl.ast.AstNodes

/**
 * A variable expression in HCL code.
 *
 * Variable expressions reference values defined elsewhere, such as input variables,
 * local values, data sources, resources, or built-in variables like `var`, `local`,
 * `data`, etc.
 *
 * Example HCL variable expressions:
 * ```
 * variable "instance_type" {
 *   description = "EC2 instance type"
 *   default     = "t2.micro"
 * }
 *
 * resource "aws_instance" "example" {
 *   ami           = var.instance_ami     // Variable expression: var
 *   instance_type = var.instance_type    // Variable expression: var
 *   subnet_id     = local.subnet_id      // Variable expression: local
 * }
 * ```
 */
class Variable extends Expr, TVariable {
  HCL::VariableExpr var;

  override string getAPrimaryQlClass() { result = "Variable" }

  Variable() { this = TVariable(var) }

  override string toString() { result = this.getName() }

  /** Gets the name of the variable being referenced. */
  string getName() { result = var.getName().getValue() }
}

/**
 * An attribute access expression in HCL code.
 *
 * Attribute access expressions use dot notation to access properties or attributes
 * of objects, resources, variables, or other complex values. They consist of an
 * expression followed by a dot and an identifier.
 *
 * Example HCL attribute access expressions:
 * ```
 * resource "aws_instance" "web" {
 *   ami           = data.aws_ami.ubuntu.id           // Access 'id' attribute of data source
 *   subnet_id     = aws_subnet.main.id               // Access 'id' attribute of resource
 *   instance_type = var.instance_config.type        // Access 'type' attribute of variable
 *   vpc_id        = local.network_config.vpc_id     // Access 'vpc_id' attribute of local
 * }
 * ```
 */
class GetAttrExpr extends Expr, TGetAttrExpr {
  private HCL::GetAttrExpr getAttr;

  override string getAPrimaryQlClass() { result = "GetExpr" }

  GetAttrExpr() { this = TGetAttrExpr(getAttr) }

  /** Gets the base expression being accessed (the part before the dot). */
  Expr getExpr() { toHclTreeSitter(result) = getAttr.getExpr() }

  /** Gets the attribute name being accessed (the identifier after the dot). */
  Identifier getKey() { toHclTreeSitter(result) = getAttr.getKey() }

  override string toString() { result = this.getExpr() + "." + this.getKey().getName() }

  override HclAstNode getAChild(string pred) {
    pred = "getExpr" and result = this.getExpr()
    or
    pred = "getKey" and result = this.getKey()
  }
}
