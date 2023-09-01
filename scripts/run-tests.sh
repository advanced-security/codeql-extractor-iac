#!/bin/bash

if which codeql >/dev/null; then
  CODEQL_BINARY="codeql"
elif gh codeql >/dev/null; then
  CODEQL_BINARY="gh codeql"
else
  gh extension install github/gh-codeql
  CODEQL_BINARY="gh codeql"
fi

$CODEQL_BINARY test run \
  --check-databases --check-unused-labels --check-repeated-labels --check-redefined-labels --check-use-before-definition \
  --search-path ./extractor-pack \
  ql/test
