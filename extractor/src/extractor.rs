use clap::Args;
use std::path::PathBuf;

use codeql_extractor::{extractor::simple, file_paths, trap};

#[derive(Args)]
pub struct Options {
    /// Sets a custom source achive folder
    #[arg(long)]
    source_archive_dir: PathBuf,

    /// Sets a custom trap folder
    #[arg(long)]
    output_dir: PathBuf,

    /// A text file containing the paths of the files to extract
    #[arg(long)]
    file_list: String,
}

pub fn run(options: Options) -> std::io::Result<()> {
    tracing_subscriber::fmt()
        .with_target(false)
        .without_time()
        .with_level(true)
        .with_env_filter(tracing_subscriber::EnvFilter::from_default_env())
        .init();

    let file_list = file_paths::path_from_string(&options.file_list);
    let file_lists: Vec<PathBuf> = vec![file_list];

    let extractor = simple::Extractor {
        prefix: "iac".to_string(),
        languages: vec![
            simple::LanguageSpec {
                prefix: "hcl",
                ts_language: tree_sitter_hcl::language(),
                node_types: tree_sitter_hcl::NODE_TYPES,
                file_globs: vec!["*.hcl".into(), "*.tf".into(), "*.tfvar".into()],
            },
            simple::LanguageSpec {
                prefix: "dockerfile",
                ts_language: tree_sitter_dockerfile::language(),
                node_types: tree_sitter_dockerfile::NODE_TYPES,
                file_globs: vec!["*Dockerfile".into(), "*Containerfile".into()],
            },
        ],
        trap_dir: options.output_dir,
        trap_compression: trap::Compression::from_env("CODEQL_IAC_TRAP_COMPRESSION"),
        source_archive_dir: options.source_archive_dir,
        file_lists,
    };

    extractor.run()
}
