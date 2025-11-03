$ErrorActionPreference = "Stop"

# Set platform
$platform = "win64"

# Check for CodeQL binary
if (Get-Command "codeql" -ErrorAction SilentlyContinue) {
	$CODEQL_BINARY = "codeql"
}
elseif (Get-Command "gh" -ErrorAction SilentlyContinue) {
	try {
		gh codeql version 2>&1 | Out-Null
		$CODEQL_BINARY = "gh codeql"
	}
 catch {
		Write-Host "Installing gh-codeql extension..."
		gh extension install github/gh-codeql
		$CODEQL_BINARY = "gh codeql"
	}
}
else {
	Write-Error "Neither 'codeql' nor 'gh' command found"
	exit 1
}

Write-Host "Creating extractor pack..."
if (Test-Path -Path extractor-pack) {
	Remove-Item -Recurse -Force extractor-pack
}
if (Test-Path -Path target) {
	Remove-Item -Recurse -Force target
}

Write-Host "Update submodules..."
git submodule update --init --recursive

Write-Host "Building extractor..."
cargo build --release

Write-Host "Generating TreeSitter library..."
cargo run --release --bin codeql-extractor-iac -- generate --dbscheme ql/lib/iac.dbscheme --library ql/lib/codeql/iac/ast/internal/TreeSitter.qll

Write-Host "Formatting generated library..."
if ($CODEQL_BINARY -eq "gh codeql") {
	gh codeql query format -i ql/lib/codeql/iac/ast/internal/TreeSitter.qll
}
else {
	codeql query format -i ql/lib/codeql/iac/ast/internal/TreeSitter.qll
}

New-Item -ItemType Directory -Path extractor-pack | Out-Null
Copy-Item -Path codeql-extractor.yml, ql/lib/iac.dbscheme, ql/lib/iac.dbscheme.stats -Destination extractor-pack/
Copy-Item -Recurse -Path downgrades, tools -Destination extractor-pack/

New-Item -ItemType Directory -Path "extractor-pack/tools/$platform" -Force | Out-Null
Copy-Item -Path "target/release/codeql-extractor-iac.exe" -Destination "extractor-pack/tools/$platform/extractor.exe"

Write-Host "Extractor pack created successfully!"
