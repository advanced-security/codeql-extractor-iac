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

    core.group("Setup", async () => {
      core.debug(`CodeQL CLI found at '${codeql.path}'`);

      // parse as JSON
      var version = await cql.runCommand(codeql, [
        "version",
        "--format",
        "terse",
      ]);

      // download the extractor
      core.info(
        `Download CodeQL IaC extractor ${codeql.repository}@${codeql.version}`,
      );
      await cql.downloadExtractor(codeql);

      var languages = await cql.runCommandJson(codeql, [
        "resolve",
        "languages",
        "--format",
        "json",
      ]);
      core.info(`CodeQL languages: ${languages}`);

      if (!languages.hasOwnProperty("iac")) {
        core.setFailed("CodeQL IaC extension not installed");
        throw new Error("CodeQL IaC extension not installed");
      }

      // download pack
      core.info(`Downloading CodeQL IaC pack '${codeql.pack}'`);
      await cql.downloadPack(codeql);

      core.info("Setup complete");
    });

    core.group("Analysis", async () => {
      core.info("Creating CodeQL database...");
      var database_path = await cql.codeqlDatabaseCreate(codeql);

      core.info("Running CodeQL analysis...");
      var sarif = await cql.codeqlDatabaseAnalyze(codeql, database_path);

      core.info(`SARIF results: '${codeql.output}'`);
    });
  } catch (error) {
    // Fail the workflow run if an error occurs
    if (error instanceof Error) core.setFailed(error.message);
  }
}

// eslint-disable-next-line @typescript-eslint/no-floating-promises
run();
