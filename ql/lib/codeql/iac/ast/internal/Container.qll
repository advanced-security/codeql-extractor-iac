import TreeSitter

/**
 * Container AST nodes
 */
cached
newtype TContainerAstNode =
  TSourceFile(DOCKERFILE::SourceFile sources) or
  TReservedWord(DOCKERFILE::ReservedWord reservedWord) or
  TImageAlias(DOCKERFILE::ImageAlias imageAlias) or
  TImageDigest(DOCKERFILE::ImageDigest imageDigest) or
  TImageName(DOCKERFILE::ImageName imageName) or
  TImageSpec(DOCKERFILE::ImageSpec imageSpecifier) or
  TImageTag(DOCKERFILE::ImageTag imageTag)

class TImage = TImageName or TImageTag or TImageDigest or TImageAlias;

/**
 * Gets the underlying TreeSitter entity for a given AST node.
 */
cached
DOCKERFILE::AstNode toContainerTreeSitter(TContainerAstNode n) {
  n = TSourceFile(result) or
  n = TReservedWord(result) or
  n = TImageAlias(result) or
  n = TImageDigest(result) or
  n = TImageName(result) or
  n = TImageSpec(result) or
  n = TImageTag(result)
}
