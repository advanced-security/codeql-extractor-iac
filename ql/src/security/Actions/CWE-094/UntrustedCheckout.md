# Checkout of untrusted code in trusted context

Combining _pull_request_target_ workflow trigger with an explicit checkout of an untrusted pull request is a dangerous practice that may lead to repository compromise.

## Recommendation

The best practice is to handle the potentially untrusted pull request via the _pull_request_ trigger so that it is isolated in an unprivileged environment. The workflow processing the pull request should then store any results like code coverage or failed/passed tests in artifacts and exit. The following workflow then starts on _workflow_run_ where it is granted write permission to the target repository and access to repository secrets, so that it can download the artifacts and make any necessary modifications to the repository or interact with third party services that require repository secrets (e.g. API tokens).

## Example

The following example allows unauthorized repository modification and secrets exfiltration:

```yaml
on: pull_request_target

jobs:
  build:
    name: Build and test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          ref: ${{ github.event.pull_request.head.sha }}

      - uses: actions/setup-node@v1
      - run: |
          npm install
          npm build

      - uses: completely/fakeaction@v2
        with:
          arg1: ${{ secrets.supersecret }}

      - uses: fakerepo/comment-on-pr@v1
        with:
          message: |
            Thank you!
```

The following example uses two workflows to handle potentially untrusted pull request in a secure manner. The receive_pr.yml is triggered first:

```yaml
name: Receive PR

# read-only repo token
# no access to secrets
on:
  pull_request:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2

      # imitation of a build process
      - name: Build
        run: /bin/bash ./build.sh

      - name: Save PR number
        run: |
          mkdir -p ./pr
          echo ${{ github.event.number }} > ./pr/NR
      - uses: actions/upload-artifact@v2
        with:
          name: pr
          path: pr/
```

The comment_pr.yml is triggered after receive_pr.yml completes:

```yaml
name: Comment on the pull request

# read-write repo token
# access to secrets
on:
  workflow_run:
    workflows: ["Receive PR"]
    types:
      - completed

jobs:
  upload:
    runs-on: ubuntu-latest
    if: >
      ${{ github.event.workflow_run.event == 'pull_request' &&
      github.event.workflow_run.conclusion == 'success' }}
    steps:
      - name: "Download artifact"
        uses: actions/github-script@v3.1.0
        with:
          script: |
            var artifacts = await github.actions.listWorkflowRunArtifacts({
               owner: context.repo.owner,
               repo: context.repo.repo,
               run_id: ${{github.event.workflow_run.id }},
            });
            var matchArtifact = artifacts.data.artifacts.filter((artifact) => {
              return artifact.name == "pr"
            })[0];
            var download = await github.actions.downloadArtifact({
               owner: context.repo.owner,
               repo: context.repo.repo,
               artifact_id: matchArtifact.id,
               archive_format: 'zip',
            });
            var fs = require('fs');
            fs.writeFileSync('${{github.workspace}}/pr.zip', Buffer.from(download.data));
      - run: unzip pr.zip
      - name: "Comment on PR"
        uses: actions/github-script@v3
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          script: |
            var fs = require('fs');
            var issue_number = Number(fs.readFileSync('./NR'));
            await github.issues.createComment({
              owner: context.repo.owner,
              repo: context.repo.repo,
              issue_number: issue_number,
              body: 'Everything is OK. Thank you for the PR!'
            });
```

## References

- GitHub Security Lab Research: [Keeping your GitHub Actions and workflows secure: Preventing pwn requests](https://securitylab.github.com/research/github-actions-preventing-pwn-requests).
- Common Weakness Enumeration: [CWE-94](https://cwe.mitre.org/data/definitions/94.html).
