import * as fs from "fs";
import * as path from "path";

import * as core from "@actions/core";
import * as toolcache from "@actions/tool-cache";
import * as toolrunner from "@actions/exec/lib/toolrunner";

export const EXTRACTOR_REPOSITORY = "advanced-security/codeql-extractor-iac";
export const EXTRACTOR_VERSION = "v0.3.0";

export interface CodeQLConfig {
  repository: string;

  version: string;
  /**
   * The path to the codeql bundle.
   */
  path: string;
}

export async function newCodeQL(): Promise<CodeQLConfig> {
  return {
    repository: EXTRACTOR_REPOSITORY,
    version: EXTRACTOR_VERSION,
    path: await findCodeQL(),
  };
}

export async function runCommand(
  config: CodeQLConfig,
  args: string[]
): Promise<any> {
  var bin = path.join(config.path, "codeql");
  return await new toolrunner.ToolRunner(bin, args).exec();
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
    core.debug(`CodeQL tools version ${candidate.version} in toolcache.`);
    return candidate.folder;
  }

  return undefined;
}

export async function downloadExtractor(config: CodeQLConfig): Promise<void> {
  // create github release url from repository owner and name
  var url = `https://github.com/${config.repository}/releases/download/${config.version}/extractor-iac.tar.gz`;
  core.info(`Downloading extractor from ${url}`);
  // use the toolcache to download the extractor
  var extractorPath = await toolcache.downloadTool(url);
  core.debug(`Extractor downloaded to ${extractorPath}`);

  // extract the tarball to codeql path
  await toolcache.extractTar(extractorPath, config.path);
  core.debug(`Extractor extracted to ${config.path}`);
}
