private import TreeSitter

/**
 * AST Common Type
 */
cached
newtype TAstNode =
  THclAstNode(HCL::AstNode node) or
  TContainerAstNode(DOCKERFILE::AstNode node) or
  TJsonAstNode(JSON::AstNode node)

// TODO
cached
AST toTreeSitter(TAstNode n) {
  n = THclAstNode(result) or
  n = TContainerAstNode(result) or
  n = TJsonAstNode(result)
}
