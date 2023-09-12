private import hcl

query predicate attributeExpr(Attribute a) { exists(a.getExpr()) }

query predicate attributeRef(Attribute a, Expr expr) { expr = a.getReference() }
