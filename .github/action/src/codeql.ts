import * as fs from "fs";
import * as path from "path";

import * as core from "@actions/core";
import * as toolcache from "@actions/tool-cache";
import * as github from "@actions/github";
import * as toolrunner from "@actions/exec/lib/toolrunner";
import { release } from "os";

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
  args: string[],
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
  args: string[],
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

export async function downloadExtractor(config: CodeQLConfig): Promise<void> {
  const octokit = github.getOctokit(core.getInput("github-token"));
  const owner_repo = config.repository.split("/");
  const release = await octokit.rest.repos.getReleaseByTag({
    owner: owner_repo[0],
    repo: owner_repo[1],
    tag: config.version,
  });
  const assets = release.data.assets
    .map((asset) => asset.browser_download_url)
    .filter((url) => url.endsWith(".tar.gz"));

  if (assets.length !== 1) {
    throw new Error(
      `Expected 1 asset to be found, but found ${assets.length} instead.`,
    );
  }
  var asset = assets[0];
  core.debug(`Downloading extractor from ${asset}`);

  // use the toolcache to download the extractor
  var extractorPath = await toolcache.downloadTool(asset);
  core.debug(`Extractor downloaded to ${extractorPath}`);

  // extract the tarball to codeql path
  await toolcache.extractTar(extractorPath, config.path);
  core.debug(`Extractor extracted to ${config.path}`);
}
