#!/usr/bin/env python3
import os
import csv
import json
from ghastoolkit import CodeQL, CodeQLPack
from ghastoolkit.utils.cli import CommandLine


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


class CoverageCommandLine(CommandLine):
    def arguments(self):
        parser = self.parser.add_argument_group("coverage")
        parser.add_argument("--pull-request", help="Output to pull_request")
        parser.add_argument("--csv", action="store_true", help="Output as csv")
        parser.add_argument("--markdown", action="store_true", help="Output as markdown")

    def run(self):
        arguments = self.parse_args()
        codeql = CodeQL()

        src = CodeQLPack("ql/src")
        src_suite = os.path.join(src.path, src.default_suite)

        sarif = json.loads(codeql.runCommand("generate", "query-help", "--format", "sarif-latest", src_suite))

        rules = sarif.get("runs", [{}])[0].get("tool", {}).get("driver", {}).get("rules", [])

        generateCsv("coverage.csv", rules, src, src_suite, display=not arguments.markdown)

        markdown = generateMarkdown(rules)
        print(markdown)
        # if arguments.pull_request:



if __name__ == "__main__":
    cli = CoverageCommandLine()
    cli.run()
