private import TreeSitter
import Hcl
import Container

/**
 * AST Common Type
 */
cached
newtype TAstNode =
  THclAstNode(HCL::AstNode node) or
  TBicepAstNode(BICEP::AstNode node) or
  TContainerAstNode(DOCKERFILE::AstNode node)
