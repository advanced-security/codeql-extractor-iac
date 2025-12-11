#!/bin/bash
set -eux

DRY_RUN=${DRY_RUN:-false}

# Extractor info
EXTRACTOR_INFO="./codeql-extractor.yml"
EXTRACTOR_NAME="${EXTRACTOR_NAME:-$(basename $(dirname $EXTRACTOR_INFO))}"
EXTRACTOR_VERSION=$(grep version $EXTRACTOR_INFO | awk '{print $2}')

LATEST_RELEASE=$(gh release list | head -n 1 | awk '{print $1}' | sed 's/v//')

if which codeql >/dev/null 2>&1; then
  CODEQL_BINARY="codeql"
elif gh codeql version >/dev/null 2>&1; then
  CODEQL_BINARY="gh codeql"
else
  gh extension install github/gh-codeql
  CODEQL_BINARY="gh codeql"
fi

echo "[+] ${EXTRACTOR_NAME} (${EXTRACTOR_VERSION})"
echo "[+] Last release: ${LATEST_RELEASE}"

if [ "$LATEST_RELEASE" != "$EXTRACTOR_VERSION" ]; then
    echo "[+] New Extractor version being released"

    # Check extracrtor-pack
    if [ ! -d "extractor-pack" ]; then
        echo "[+] No extractor-pack found"
        exit 1
    fi

    echo "[+] Install pack dependencies"
    $CODEQL_BINARY pack install "./ql/lib"

    echo "[+] Add queries to extractor-pack"
    $CODEQL_BINARY pack create --output="./extractor-pack/qlpacks" "./ql/lib"
    $CODEQL_BINARY pack create --output="./extractor-pack/qlpacks" "./ql/src"

    # bundle extractor
    tar czf extractor-$EXTRACTOR_NAME.tar.gz extractor-pack

    if [ "$DRY_RUN" = "true" ]; then
        echo "[+] Dry run - skipping release"
        exit 0
    fi

    export GH_TOKEN=$GITHUB_TOKEN

    # create release
    gh release create "v$EXTRACTOR_VERSION" \
        --notes "$EXTRACTOR_NAME Extractor v$EXTRACTOR_VERSION" \
        extractor-$EXTRACTOR_NAME.tar.gz

else
    echo "[+] Extractor is up to date"
fi
