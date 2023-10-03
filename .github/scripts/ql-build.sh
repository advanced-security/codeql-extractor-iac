#!/bin/bash

CODEQL_REPOSITORY_PATH="${CODEQL_REPOSITORY_PATH:-$HOME/.codeql/codeql-ql}"
echo "CodeQL repository path: $CODEQL_REPOSITORY_PATH"

if [ ! -d "$CODEQL_REPOSITORY_PATH" ]; then
  echo "CodeQL repository not found. Cloning..."
  mkdir -p "$HOME/.codeql"

  git clone \
    --depth 1 \
    https://github.com/github/codeql.git\
    "$CODEQL_REPOSITORY_PATH"
fi

pushd "$CODEQL_REPOSITORY_PATH/ql" > /dev/null

echo "Building QL Extractor..."
./scripts/create-extractor-pack.sh

popd > /dev/null
