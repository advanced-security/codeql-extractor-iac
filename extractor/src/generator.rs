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
    tracing_subscriber::fmt()
        .with_target(false)
        .without_time()
        .with_level(true)
        .with_env_filter(tracing_subscriber::EnvFilter::from_default_env())
        .init();

    let languages = vec![
        Language {
            name: "HCL".to_owned(),
            node_types: tree_sitter_hcl::NODE_TYPES,
        },
        Language {
            name: "DOCKERFILE".to_owned(),
            node_types: tree_sitter_dockerfile::NODE_TYPES,
        },
        Language {
            name: "BICEP".to_owned(),
            node_types: tree_sitter_bicep::NODE_TYPES,
        },
    ];

    generate(languages, options.dbscheme, options.library)
}
