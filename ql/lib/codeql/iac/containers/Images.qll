private import codeql.iac.ast.internal.AstNodes
private import codeql.iac.ast.AstNode::Containers
private import codeql.Locations
private import codeql.files.FileSystem

/**
 * A container image.
 */
class ContainerImage extends AstNode, TImageSpec {
  private DOCKERFILE::ImageSpec imageSpec;

  override string getAPrimaryQlClass() { result = "Image" }

  ContainerImage() { this = TImageSpec(imageSpec) }

  ContainerImageName getName() { toContainerTreeSitter(result) = imageSpec.getName() }

  ContainerImageTag getTag() { toContainerTreeSitter(result) = imageSpec.getTag() }
}

/**
 * A container image name.
 */
class ContainerImageName extends AstNode, TImageName {
  private DOCKERFILE::ImageName imageName;

  override string getAPrimaryQlClass() { result = "ImageName" }

  ContainerImageName() { this = TImageName(imageName) }

  /**
   * Returns the name of the image.
   */
  string getValue() { none() }
}

/**
 * A container image tag.
 */
class ContainerImageTag extends AstNode, TImageTag {
  private DOCKERFILE::ImageTag imageTag;

  override string getAPrimaryQlClass() { result = "ImageTag" }

  ContainerImageTag() { this = TImageTag(imageTag) }

  /**
   * Returns the value of the tag.
   */
  string getValue() { none() }
}

/**
 * A container image alias.
 */
class ContainerImageAlias extends AstNode, TImageAlias {
  private DOCKERFILE::ImageAlias imageAlias;

  override string getAPrimaryQlClass() { result = "ImageAlias" }

  ContainerImageAlias() { this = TImageAlias(imageAlias) }
}
