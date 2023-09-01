private import TreeSitter
import Hcl
import Container
import Json

/**
 * AST Common Type
 */
cached
newtype TAstNode =
  THclAstNode(HCL::AstNode node) or
  TContainerAstNode(DOCKERFILE::AstNode node) or
  TJsonAstNode(JSON::AstNode node)
