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
            desugar: None,
        },
        Language {
            name: "DOCKERFILE".to_owned(),
            node_types: tree_sitter_dockerfile::NODE_TYPES,
            desugar: None,
        },
    ];

    let library = options.library;
    generate(
        languages,
        options.dbscheme,
        library.clone(),
        false,
        "run `./scripts/create-extractor-pack.sh`",
    )?;

    // Overlay-local ASTs cannot reference the global Locations::Location type.
    let qll = std::fs::read_to_string(&library)?
        .replace("import codeql.Locations as L\n", "")
        .replace(
            "L::Location getLocation()",
            "@location_default getLocation()",
        );
    std::fs::write(library, qll)
}
