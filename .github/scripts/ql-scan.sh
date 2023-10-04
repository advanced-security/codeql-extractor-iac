#!/bin/bash

CODEQL_REPOSITORY_PATH="${CODEQL_REPOSITORY_PATH:-$HOME/.codeql/codeql-ql}"
CODEQL_SUITE="${CODEQL_SUITE:-$CODEQL_REPOSITORY_PATH/ql/ql/src/codeql-suites/ql-code-scanning.qls}"

if which codeql >/dev/null; then
  CODEQL_BINARY="codeql"
elif gh codeql >/dev/null; then
  CODEQL_BINARY="gh codeql"
else
  gh extension install github/gh-codeql
  CODEQL_BINARY="gh codeql"
fi

$CODEQL_BINARY database create \
    --language ql --overwrite \
    --search-path "$CODEQL_REPOSITORY_PATH/ql/extractor-pack" \
    ../ql-for-ql-db

$CODEQL_BINARY database analyze \
    --format=sarif-latest \
    --additional-packs "$CODEQL_REPOSITORY_PATH/ql" \
    --output=ql-for-ql.sarif \
    ../ql-for-ql-db \
    $CODEQL_SUITE
