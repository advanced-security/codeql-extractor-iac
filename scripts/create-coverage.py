#!/usr/bin/env python3
import os
import csv
import json
import yaml
import logging
from dataclasses import dataclass
from typing import Optional, List
from ghastoolkit import CodeQL, CodeQLPack
from ghastoolkit.utils.cli import CommandLine

logger = logging.getLogger(__name__)

def generateCsv(csvfile, rules, src, src_suite, display: bool = True):
    headers = ["ID", "Name", "Suite", "Severity"]
    if display:
        print(f"Source / Queries :: {src} :: {src_suite}")


    with open("coverage.csv", "w") as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(headers)

        for rule in rules:
            id = rule.get("id")
            props = rule.get("properties", {})
            name = props.get("name")

            if display:
                print(f"Rule :: {id}")

            severity = props.get("security-severity", {})

            writer.writerow([id, name, "code-scanning", severity])

def generateMarkdown(rules, suite: str = "code-scanning") -> str:
    markdown = """\
# Code Scanning Coverage Report

This report shows the coverage of Code Scanning rules for the current repository.

| Suite         | Query ID                                   | Severity |
| ------------- | ------------------------------------------ | -------- |
"""

    for rule in rules:
        id = rule.get("id")
        props = rule.get("properties", {})
        severity = props.get("security-severity", "NA")

        markdown += f"| {suite} | {id:<42} | {severity:<8} |\n"
    return markdown

@dataclass
class Rule:
    id: str 
    name: str
    description: Optional[str] = None
    severity: Optional[float] = None
    tags: Optional[List[str]] = None
    impacts: Optional[List[str]] = None

    required: Optional[List[str]] = None

    def __post_init__(self):
        if self.severity:
            self.severity = float(self.severity)

    def __str__(self) -> str:
        return f"Rule({self.id}, '{self.severity}')"

    @staticmethod
    def load(path: str) -> Optional["Rule"]:
        """Load the query from the path."""
        if not os.path.exists(path):
            raise Exception(f"Query path not found: {path}")
        with open(path, "r") as handle:
            query = yaml.safe_load(handle)
        return Rule(**query)


class CoverageCommandLine(CommandLine):
    def arguments(self):
        self.addModes(["report", "rules"])

        parser = self.parser.add_argument_group("coverage")
        parser.add_argument("--pull-request", help="Output to pull_request")
        parser.add_argument("--csv", action="store_true", help="Output as csv")
        parser.add_argument("--markdown", action="store_true", help="Output as markdown")

        parser.add_argument("--rules", default="./scripts/rules", help="Path to query rules folder")

    def run(self):
        arguments = self.parse_args()

        if arguments.mode == "report":
            self.runReport(arguments)
        elif arguments.mode == "rules":
            self.runRules(arguments)

    def generateQueries(self, codeql: CodeQL, src_suite: str):
        sarif = json.loads(codeql.runCommand("generate", "query-help", "--format", "sarif-latest", src_suite))
        rules = sarif.get("runs", [{}])[0].get("tool", {}).get("driver", {}).get("rules", [])
        return rules

    
    def runReport(self, arguments):
        """Run and generate the report."""
        codeql = CodeQL()

        src = CodeQLPack("ql/src")
        src_suite = os.path.join(src.path, src.default_suite)

        rules = self.generateQueries(codeql, src_suite)

        generateCsv("coverage.csv", rules, src, src_suite, display=not arguments.markdown)

        markdown = generateMarkdown(rules)
        print(markdown)

    def runRules(self, arguments):
        """Run and generate the queries."""

        codeql = CodeQL()

        src = CodeQLPack("ql/src")
        src_suite = os.path.join(src.path, src.default_suite)

        # load the queries and config
        rules = []
        config = {}

        if not os.path.exists(arguments.rules):
            logger.error("Queries folder not found.")
            raise Exception("Queries folder not found.")
        config_path = os.path.join(arguments.rules, "config.yml")
        with open(config_path, "r") as handle:
            config = yaml.safe_load(handle)

        for root, dirs, files in os.walk(arguments.rules):
            for query_file in files:
                if query_file == "config.yml":
                    continue

                rules.append(Rule.load(os.path.join(root, query_file)))

        logger.info(f"Loaded {len(rules)} rules.")
        # list of all of the queries included in the pack
        queries = self.generateQueries(codeql, src_suite)

        for query in queries:
            id = query.get("id")
            # {language}/{cloud_provider}/{category}
            try:
                id_lang, id_provider, id_name = id.split("/")
            except ValueError:
                # TODO :: handle this better
                logger.error(f"  - invalid rule id `{id}`")
                continue

            # print(f"Rule :: {id_lang} :: {id_provider} :: {id_name}")
            # check: language
            if id_lang not in config.get("languages", []):
                logger.error(f"{id} :: language `{id_lang}` not included in config")
            # check: cloud provider
            if id_provider not in config.get("providers", []):
                logger.error(f"{id} :: provider `{id_provider}` not included in config")

            # find the rule in the rules list
            rule = next((r for r in rules if r.name == id_name), None)
            # check: name
            if not rule:
                logger.debug(f"{id} :: rule `{id}` not found in rules")
                continue

            # check: severity score
            severity_score = float(query.get("properties", {}).get("security-severity", 0))
            if not severity_score or severity_score == "":
                logger.error(f"{id} :: severity not set")
            elif severity_score != rule.severity:
                logger.error(f"{id} :: severity `{severity_score}` does not match rule `{rule.severity}`")

            # check: required
            if rule.required:
                fullname = f"{id_lang}/{id_provider}"
                if fullname not in rule.required:
                    logger.error(f"{id} :: required rule `{fullname}` not included")

            # tags
            tags = query.get("properties", {}).get("tags", [])

            # check: provider tags
            if id_provider not in tags:
                logger.error(f"{id} :: provider `{id_provider}` not in tags")
            # check: language tags
            alias = config.get("languages_aliases", {}).get(id_lang)
            if alias and alias not in tags:
                logger.error(f"{id} :: language alias `{alias}` not in tags")
            elif not alias and id_lang not in tags:
                logger.error(f"{id} :: language `{id_lang}` not in tags")
            # TODO check: category id tags
            # if rule.id not in tags:
            #     logger.error(f"{id} :: category id `{rule.id}` not in tags")
            # check: rule tags
            for tag in rule.tags:
                if tag not in tags:
                    logger.error(f"{id} :: tag `{tag}` not in tags")


if __name__ == "__main__":
    cli = CoverageCommandLine()
    cli.run()
