private import bicep as L
private import L
private import codeql.util.test.InlineExpectationsTest

module Impl implements InlineExpectationsTestSig {
  class ExpectationComment extends L::Comment {
    /** Gets the contents of the given comment, _without_ the preceding comment marker (`//`). */
    override string getContents() { result = super.getContents() }
  }

  class Location = L::Location;
}
