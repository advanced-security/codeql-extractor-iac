/**
 * Inline expectation tests for HCL.
 * See `shared/util/codeql/util/test/InlineExpectationsTest.qll`
 */

private import hcl as HCL
private import codeql.util.test.InlineExpectationsTest

private module Impl implements InlineExpectationsTestSig {
  private import codeql.hcl.ast.internal.TreeSitter as TS

  private newtype TExpectationComment = MkExpectationComment(TS::HCL::Comment comment)

  /**
   * Represents a line comment.
   */
  class ExpectationComment extends TExpectationComment {
    TS::HCL::Comment comment;

    ExpectationComment() {
      this = MkExpectationComment(comment) and comment.getValue().matches("#%")
    }

    /** Returns the contents of the given comment, _without_ the preceding comment marker (`#`). */
    string getContents() {
      /* TODO: Fix working with `//` comments as well */
      result = comment.getValue().suffix(1)
    }

    /** Gets a textual representation of this element. */
    string toString() { result = comment.toString() }

    /** Gets the location of this comment. */
    Location getLocation() { result = comment.getLocation() }
  }

  class Location = HCL::Location;
}

import Make<Impl>
