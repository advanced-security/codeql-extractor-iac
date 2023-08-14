#!/bin/sh

set -eu

"${CODEQL_DIST}/codeql" database index-files \
    --prune="**/*.testproj" \
    --include-extension=.hcl \
    --include-extension=.dbscheme \
    --size-limit=5m \
    --language=iac \
    --working-dir=.\
    "$CODEQL_EXTRACTOR_IAC_WIP_DATABASE"

exec "${CODEQL_DIST}/codeql" database index-files \
    --prune="**/*.testproj" \
    --include-extension=.yml \
    --size-limit=5m \
    --language=yaml \
    --working-dir=.\
    "$CODEQL_EXTRACTOR_IAC_WIP_DATABASE"