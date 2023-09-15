private import codeql.iac.ast.Bicep
private import codeql.iac.azure.Bicep

query predicate ast(BicepAstNode ast) { any() }
