#!/bin/bash

# get the argument 
TESTS_DIR=$1
if [ -z "$TESTS_DIR" ]; then
  TESTS_DIR="ql/test"
fi

if which codeql >/dev/null; then
  CODEQL_BINARY="codeql"
elif gh codeql >/dev/null; then
  CODEQL_BINARY="gh codeql"
else
  gh extension install github/gh-codeql
  CODEQL_BINARY="gh codeql"
fi

$CODEQL_BINARY pack install ql/test

echo "Running tests in $TESTS_DIR"

$CODEQL_BINARY test run \
  -j 0 \
  --check-databases --check-unused-labels --check-repeated-labels --check-redefined-labels --check-use-before-definition \
  --search-path ./extractor-pack \
  "$TESTS_DIR"
