#!/bin/bash

set -e

EXTRACTOR_NAME="iac"
EXTRACTOR_LOCATIONS="$HOME/.codeql/extractors"


mkdir -p $EXTRACTOR_LOCATIONS

gh release list -L 1 -R "advanced-security/codeql-extractor-$EXTRACTOR_NAME"

gh release download \
    -R "advanced-security/codeql-extractor-$EXTRACTOR_NAME" \
    -D "$EXTRACTOR_LOCATIONS" \
    --clobber \
    --pattern 'extractor-*.tar.gz'

tar -zxf "$EXTRACTOR_LOCATIONS/extractor-$EXTRACTOR_NAME.tar.gz" --directory "$EXTRACTOR_LOCATIONS"