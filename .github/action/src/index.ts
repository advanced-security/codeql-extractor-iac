import * as core from "@actions/core";
import * as cql from "./codeql";

/**
 * The main function for the action.
 * @returns {Promise<void>} Resolves when the action is complete.
 */
export async function run(): Promise<void> {
  try {
    // set up codeql
    var codeql = await cql.newCodeQL();

    core.debug(`CodeQL CLI found at '${codeql.path}'`);

    var version = await cql.runCommand(codeql, ["version"]);
    core.info(`CodeQL CLI version: ${version}`);

    // download the extractor
    await cql.downloadExtractor(codeql);

    //
  } catch (error) {
    // Fail the workflow run if an error occurs
    if (error instanceof Error) core.setFailed(error.message);
  }
}

// eslint-disable-next-line @typescript-eslint/no-floating-promises
run();