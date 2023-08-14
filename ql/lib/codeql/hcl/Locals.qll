import hcl

Expr getLocal(string name) {
  exists(Block locals | locals.getType() = "locals" and result = locals.getAttribute(name))
}
