#!/usr/bin/env python3
import os
import csv
import json
from ghastoolkit import CodeQL, CodeQLPack

codeql = CodeQL()

src = CodeQLPack("ql/src")
src_suite = os.path.join(src.path, src.default_suite)


print(f"Source / Queries :: {src} :: {src_suite}")


sarif = json.loads(codeql.runCommand("generate", "query-help", "--format", "sarif-latest", src_suite))

rules = sarif.get("runs", [{}])[0].get("tool", {}).get("driver", {}).get("rules", [])


headers = ["ID", "Name", "Suite", "Severity"]
with open("coverage.csv", "w") as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(headers)

    for rule in rules:
        print(f"Rule :: {rule}")

        id = rule.get("id")
        props = rule.get("properties", {})
        name = props.get("name")

        severity = props.get("security-severity", {})


        writer.writerow([id, name, "code-scanning", severity])
