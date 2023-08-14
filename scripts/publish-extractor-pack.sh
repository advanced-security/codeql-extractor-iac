#!/bin/bash

# Extractor info
EXTRACTOR_INFO="./codeql-extractor.yml"
EXTRACTOR_NAME="iac"
EXTRACTOR_VERSION=$(grep version $EXTRACTOR_INFO | awk '{print $2}')

echo "[+] ${EXTRACTOR_NAME} (${EXTRACTOR_VERSION})"

# bundle extractor
tar czf extractor-$EXTRACTOR_NAME.tar.gz extractor-pack

export GH_TOKEN=$GITHUB_TOKEN

# create release
gh release create "v$EXTRACTOR_VERSION" \
    --notes "$EXTRACTOR_NAME Extractor v$EXTRACTOR_VERSION" \
    extractor-$EXTRACTOR_NAME.tar.gz