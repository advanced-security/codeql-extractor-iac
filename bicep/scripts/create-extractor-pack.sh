#!/bin/bash
set -eux

CARGO=cargo

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  platform="linux64"
  if which cross; then
    CARGO=cross
  fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
  platform="osx64"
else
  echo "Unknown OS"
  exit 1
fi

if which codeql >/dev/null; then
  CODEQL_BINARY="codeql"
elif gh codeql >/dev/null; then
  CODEQL_BINARY="gh codeql"
else
  gh extension install github/gh-codeql
  CODEQL_BINARY="gh codeql"
fi

cargo build --release

mkdir -p ql/lib/codeql/bicep/ast/internal/
cargo run --release --bin codeql-extractor-bicep -- \
  generate \
  --dbscheme ql/lib/bicep.dbscheme \
  --library ql/lib/codeql/bicep/ast/internal/TreeSitter.qll

$CODEQL_BINARY query format -i ql/lib/codeql/bicep/ast/internal/TreeSitter.qll

echo "Create extractor pack for $platform"
rm -rf extractor-pack
mkdir -p extractor-pack
cp -r codeql-extractor.yml downgrades tools ql/lib/bicep.dbscheme ql/lib/bicep.dbscheme.stats extractor-pack/

# Tools
mkdir -p extractor-pack/tools/${platform}
cp target/release/codeql-extractor-bicep extractor-pack/tools/${platform}/extractor
chmod +x extractor-pack/tools/*.sh
