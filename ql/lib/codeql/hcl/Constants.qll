import hcl
import Locals

private string evalStringConstant(Expr e) {
  result = e.(StringLiteral).getValue()
  or
  e.(GetAttrExpr).getExpr().(Variable).getName() = "local" and
  result = evalStringConstant(getLocal(e.(GetAttrExpr).getKey().getName()))
  // TODO: handle string interpolation
}

class ConstantExpr extends Expr {
  string value;

  ConstantExpr() { value = evalStringConstant(this) }

  string getStringValue() { result = value }
}
