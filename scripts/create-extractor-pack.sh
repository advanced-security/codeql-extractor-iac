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
cargo run --release --bin codeql-extractor-iac -- generate --dbscheme ql/lib/iac.dbscheme --library ql/lib/codeql/iac/ast/internal/TreeSitter.qll
$CODEQL_BINARY query format -i ql/lib/codeql/iac/ast/internal/TreeSitter.qll

rm -rf extractor-pack
mkdir -p extractor-pack
cp -r codeql-extractor.yml downgrades tools ql/lib/iac.dbscheme ql/lib/iac.dbscheme.stats extractor-pack/
mkdir -p extractor-pack/tools/${platform}
cp target/release/codeql-extractor-iac extractor-pack/tools/${platform}/extractor

pushd ql/lib 
codeql pack create --output=$HOME/.codeql/packages .
popd
