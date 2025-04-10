use clap::Args;
use std::path::PathBuf;

use codeql_extractor::generator::{generate, language::Language};

#[derive(Args)]
pub struct Options {
    /// Path of the generated dbscheme file
    #[arg(long)]
    dbscheme: PathBuf,

    /// Path of the generated QLL file
    #[arg(long)]
    library: PathBuf,
}

pub fn run(options: Options) -> std::io::Result<()> {
    codeql_extractor::extractor::set_tracing_level("bicep");

    let languages = vec![Language {
        name: "BICEP".to_owned(),
        node_types: tree_sitter_bicep::NODE_TYPES,
    }];

    generate(languages, options.dbscheme, options.library)
}
