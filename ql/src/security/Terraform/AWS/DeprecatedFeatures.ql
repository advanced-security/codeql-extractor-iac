/**
 * @name Terraform AWS Provider Deprecated Features
 * @description Terraform AWS Provider Deprecated Features
 * @kind problem
 * @problem.severity warning
 * @security-severity 3.0
 * @precision high
 * @id hcl/aws/deprecated-features
 * @tags maintenance
 */

import hcl

abstract class DeprecatedFeatures extends Expr {
  string getFeature() { result = "NA" }
}

class S3Logging extends DeprecatedFeatures {
  S3Logging() {
    exists(AWS::S3Bucket b | b.hasAttribute("logging") and this = b.getAttribute("logging"))
  }

  override string getFeature() { result = "logging" }
}

from DeprecatedFeatures features
select features, "Deprecated feature \"" + features.getFeature() + "\" used"
