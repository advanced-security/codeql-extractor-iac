private import codeql.iac.ast.internal.Hcl
private import codeql.hcl.ast.AstNodes

class FunctionCall extends Expr, TFunctionCall {
  HCL::FunctionCall functionCall;

  override string getAPrimaryQlClass() { result = "FunctionCall" }

  FunctionCall() { this = TFunctionCall(functionCall) }

  Expr getCallee() { toHclTreeSitter(result) = functionCall.getFunction() }

  Expr getArgument(int i) { toHclTreeSitter(result) = functionCall.getArgument(i) }

  override HclAstNode getAChild(string pred) {
    pred = "getCallee" and result = this.getCallee()
    or
    pred = "getArgument" and result = this.getArgument(_)
  }
}
