/**
 * Classes and predicates for analyzing HCL function call expressions.
 * Function calls invoke built-in functions or user-defined functions with
 * arguments to compute values dynamically.
 */

private import codeql.iac.ast.internal.Hcl
private import codeql.hcl.ast.AstNodes

/**
 * A function call expression in HCL code.
 *
 * Function calls invoke functions with zero or more arguments to compute values.
 * HCL provides many built-in functions for string manipulation, mathematical
 * operations, data transformation, and more.
 *
 * Example HCL function calls:
 * ```
 * resource "aws_instance" "example" {
 *   count                = length(var.availability_zones)    // Function call: length()
 *   ami                  = data.aws_ami.ubuntu.id
 *   instance_type        = "t2.micro"
 *   availability_zone    = element(var.availability_zones, count.index)  // Function call: element()
 *
 *   tags = {
 *     Name = format("web-server-%02d", count.index + 1)     // Function call: format()
 *   }
 * }
 *
 * locals {
 *   subnet_ids = concat(                                     // Function call: concat()
 *     aws_subnet.public[*].id,
 *     aws_subnet.private[*].id
 *   )
 *   timestamp = formatdate("YYYY-MM-DD", timestamp())       // Function calls: formatdate(), timestamp()
 * }
 * ```
 */
class FunctionCall extends Expr, TFunctionCall {
  HCL::FunctionCall functionCall;

  override string getAPrimaryQlClass() { result = "FunctionCall" }

  FunctionCall() { this = TFunctionCall(functionCall) }

  /** Gets the function being called (typically an identifier). */
  Expr getCallee() { toHclTreeSitter(result) = functionCall.getFunction() }

  /** Gets the argument at the specified index. */
  Expr getArgument(int i) { toHclTreeSitter(result) = functionCall.getArgument(i) }

  override HclAstNode getAChild(string pred) {
    pred = "getCallee" and result = this.getCallee()
    or
    pred = "getArgument" and result = this.getArgument(_)
  }
}
