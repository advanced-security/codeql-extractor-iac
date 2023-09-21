import iac
import codeql.hcl.security.WeakEncryption
import TestUtilities.hcl.InlineExpectationsTest

module GoMicroTest implements TestSig {
  string getARelevantTag() { result = ["weakKey"] }

  predicate hasActualResult(Location location, string element, string tag, string value) {
    exists(HclAstNode node |
      node.hasLocationInfo(location.getFile().getAbsolutePath(), location.getStartLine(),
        location.getStartColumn(), location.getEndLine(), location.getEndColumn()) and
      (
        node instanceof WeakEncryption::AzureVaultKey and
        element = node.toString() and
        value = "\"" + node.toString() + "\"" and
        tag = "weakKey"
      )
    )
  }
}

import MakeTest<GoMicroTest>
