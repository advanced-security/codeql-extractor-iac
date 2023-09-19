import * as fs from "fs";
import * as path from "path";

import * as core from "@actions/core";
import * as toolcache from "@actions/tool-cache";
import * as github from "@actions/github";
import * as toolrunner from "@actions/exec/lib/toolrunner";

export const EXTRACTOR_REPOSITORY = "advanced-security/codeql-extractor-iac";
export const EXTRACTOR_VERSION = "v0.0.3";

export interface CodeQLConfig {
  // The path to the codeql bundle.
  path: string;
  // The language to use for analysis.
  language: string;
  // The repository to the extractor.
  repository: string;
  // The version of the extractor to use.
  version: string;
  // CodeQL pack to use for analysis.
  pack: string;
  // The codeql suite to use for analysis.
  suite: string;
  // The source root to use for analysis.
  source_root?: string;
  // The output file for the SARIF file.
  output?: string;
}

export async function newCodeQL(): Promise<CodeQLConfig> {
  var version = core.getInput("codeql-version");
  if (version === "") {
    version = EXTRACTOR_VERSION;
  }

  return {
    language: "iac",
    repository: EXTRACTOR_REPOSITORY,
    version: version,
    path: await findCodeQL(),
    pack: "advanced-security/iac-queries",
    suite: "codeql-suites/iac-code-scanning.qls",
    source_root: core.getInput("source-root"),
    output: core.getInput("sarif"),
  };
}

export async function runCommand(
  config: CodeQLConfig,
  args: string[]
): Promise<any> {
  var bin = path.join(config.path, "codeql");
  let output = "";
  var options = {
    listeners: {
      stdout: (data: Buffer) => {
        output += data.toString();
      },
    },
  };

  await new toolrunner.ToolRunner(bin, args, options).exec();
  core.debug(`Finished running command :: ${bin} ${args.join(" ")}`);

  return output.trim();
}

export async function runCommandJson(
  config: CodeQLConfig,
  args: string[]
): Promise<object> {
  return JSON.parse(await runCommand(config, args));
}
async function findCodeQL(): Promise<string> {
  // check if codeql is in the toolcache
  var codeqlPath = await findCodeQlInToolcache();
  if (codeqlPath !== undefined) {
    return codeqlPath;
  }
  // default to the codeql in the path
  return "codeql";
}

async function findCodeQlInToolcache(): Promise<string | undefined> {
  const candidates = toolcache
    .findAllVersions("CodeQL")
    .map((version) => ({
      folder: toolcache.find("CodeQL", version),
      version,
    }))
    .filter(({ folder }) => fs.existsSync(path.join(folder, "pinned-version")));

  if (candidates.length === 1) {
    const candidate = candidates[0];
    core.info(`CodeQL tools found in toolcache: '${candidate.folder}'.`);
    core.debug(`CodeQL toolcache version: '${candidate.version}'.`);

    return path.join(candidate.folder, "codeql");
  }

  core.warning(`No CodeQL tools found in toolcache.`);

  return undefined;
}

export async function downloadExtractor(config: CodeQLConfig): Promise<string> {
  const octokit = github.getOctokit(core.getInput("token"));
  const owner_repo = config.repository.split("/");

  core.debug(`Downloading and installing extractor...`);

  if (config.version === "latest") {
    var release = await octokit.rest.repos.getLatestRelease({
      owner: owner_repo[0],
      repo: owner_repo[1],
    });
  } else if (config.version === "compile") {
    core.info("Compiling extractor from source...");
    core.warning("This is not recommended for production use");
    core.warning("Feature not yet implemented");
    return "";
  } else {
    var release = await octokit.rest.repos.getReleaseByTag({
      owner: owner_repo[0],
      repo: owner_repo[1],
      tag: config.version,
    });
  }
  // we assume there is only one tar.gz asset
  const assets = release.data.assets.filter((asset) =>
    asset.browser_download_url.endsWith(".tar.gz")
  );

  if (assets.length !== 1) {
    throw new Error(
      `Expected 1 asset to be found, but found ${assets.length} instead.`
    );
  }
  var asset = assets[0];
  core.debug(`Downloading extractor from ${asset}`);

  // use the toolcache to download the extractor
  var extractorPath = await toolcache.downloadTool(
    asset.url,
    undefined,
    `token ${core.getInput("token")}`,
    {
      accept: "application/octet-stream",
    }
  );
  core.debug(`Extractor downloaded to ${extractorPath}`);

  core.debug(`Extracting extractor to ${config.path}`);
  await toolcache.extractTar(extractorPath, config.path);

  core.debug(`Successfully installed extractor`);
  return config.path;
}

export async function downloadPack(codeql: CodeQLConfig): Promise<boolean> {
  try {
    await runCommand(codeql, ["pack", "download", codeql.pack]);
    return true;
  } catch (error) {
    core.warning("Failed to download pack from GitHub...");
  }
  return false;
}

export async function codeqlDatabaseCreate(
  codeql: CodeQLConfig
): Promise<string> {
  // get runner temp directory for database
  var temp = process.env["RUNNER_TEMP"];
  if (temp === undefined) {
    temp = "/tmp";
  }
  var database_path = path.join(temp, "codeql-iac-db");
  var source_root =
    codeql.source_root || process.env["GITHUB_WORKSPACE"] || "./";

  await runCommand(codeql, [
    "database",
    "create",
    "--language",
    codeql.language,
    "--source-root",
    source_root,
    database_path,
  ]);

  return database_path;
}

export async function codeqlDatabaseAnalyze(
  codeql: CodeQLConfig,
  database_path: string
): Promise<string> {
  var codeql_output = codeql.output || "codeql-iac.sarif";

  var cmd = [
    "database",
    "analyze",
    "--format",
    "sarif-latest",
    "--sarif-add-query-help",
    "--output",
    codeql_output,
  ];

  // remote pack or local pack
  if (codeql.pack.startsWith("advanced-security/")) {
    var suite = codeql.pack + ":" + codeql.suite;
  } else {
    // assume path
    var suite = path.join(codeql.pack, codeql.suite);
    cmd.push("--search-path", codeql.pack);
  }

  cmd.push(database_path, suite);

  await runCommand(codeql, cmd);

  return codeql_output;
}
