#!/bin/bash

# Extractor info
EXTRACTOR_INFO="./codeql-extractor.yml"
EXTRACTOR_NAME="iac"
EXTRACTOR_VERSION=$(grep version $EXTRACTOR_INFO | awk '{print $2}')

LATEST_RELEASE=$(gh release list | head -n 1 | awk '{print $1}' | sed 's/v//')

echo "[+] ${EXTRACTOR_NAME} (${EXTRACTOR_VERSION})"
echo "[+] Last release: ${LATEST_RELEASE}"

if [ "$LATEST_RELEASE" != "$EXTRACTOR_VERSION" ]; then
    echo "[+] New Extractor version being released"

    # create extractor pack
    ./scripts/create-extractor-pack.sh

    # bundle extractor
    tar czf extractor-$EXTRACTOR_NAME.tar.gz extractor-pack

    export GH_TOKEN=$GITHUB_TOKEN

    # create release
    gh release create "v$EXTRACTOR_VERSION" \
        --notes "$EXTRACTOR_NAME Extractor v$EXTRACTOR_VERSION" \
        extractor-$EXTRACTOR_NAME.tar.gz

else
    echo "[+] Extractor is up to date"
fi
