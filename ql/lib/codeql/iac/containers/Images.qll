private import codeql.iac.ast.internal.AstNodes
private import codeql.iac.ast.AstNode::Containers
private import codeql.Locations
private import codeql.files.FileSystem

/**
 * A container image.
 */
class Image extends AstNode, TImage {
  override string getAPrimaryQlClass() { result = "Image" }
}

class ImageName extends AstNode, TImageName {
  private DOCKERFILE::ImageName imageName;

  override string getAPrimaryQlClass() { result = "ImageName" }

  ImageName() { this = TImageName(imageName) }
}
