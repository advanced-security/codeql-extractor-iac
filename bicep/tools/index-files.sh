#!/bin/sh

set -eu

exec "${CODEQL_EXTRACTOR_BICEP_ROOT}/tools/${CODEQL_PLATFORM}/extractor" \
        extract \
        --file-list "$1" \
        --source-archive-dir "$CODEQL_EXTRACTOR_BICEP_SOURCE_ARCHIVE_DIR" \
        --output-dir "$CODEQL_EXTRACTOR_BICEP_TRAP_DIR"