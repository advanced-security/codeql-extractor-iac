#!/bin/bash

set -e

EXTRACTOR_NAME="${1:iac}"
EXTRACTOR_LOCATIONS="$HOME/.codeql/extractors"

if [ -z "$EXTRACTOR_NAME" ]; then
    echo "No extractor name provided"
    exit 1
fi

mkdir -p $EXTRACTOR_LOCATIONS

gh release list -L 1 -R "advanced-security/codeql-extractor-$EXTRACTOR_NAME"

gh release download \
    -R "advanced-security/codeql-extractor-$EXTRACTOR_NAME" \
    -D "$EXTRACTOR_LOCATIONS" \
    --clobber \
    --pattern 'extractor-*.tar.gz'

tar -zxf "$EXTRACTOR_LOCATIONS/extractor-$EXTRACTOR_NAME.tar.gz" --directory "$EXTRACTOR_LOCATIONS"