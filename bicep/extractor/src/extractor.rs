use clap::Args;
use std::path::PathBuf;

use codeql_extractor::{
    extractor::simple::{Extractor, LanguageSpec},
    file_paths, trap,
};

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

    let extractor = Extractor {
        prefix: "bicep".to_string(),
        languages: vec![
            // Bicep
            LanguageSpec {
                prefix: "bicep",
                ts_language: tree_sitter_bicep::LANGUAGE.into(),
                node_types: tree_sitter_bicep::NODE_TYPES,
                file_globs: vec!["*.bicep".into()],
            },
        ],
        trap_dir: options.output_dir,
        trap_compression: trap::Compression::from_env("CODEQL_BICEP_TRAP_COMPRESSION"),
        source_archive_dir: options.source_archive_dir,
        file_lists,
    };

    extractor.run()
}
