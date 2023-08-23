/**
 * @name Using latest images
 * @description Using the latest version of an image can lead to unexpected changes in your container.
 * @kind problem
 * @problem.severity note
 * @security-severity 4.0
 * @precision high
 * @id iac/containers/latest-images
 * @tags security
 */

import iac

from ContainerImage image
where image.getTag().getValue() = ["latest", "main", "master"]
select image, "using latest image"
