# Actions Permissions not set to least privilege

Action workflows should be configured with the least privilege required to complete the task.
An Action by default without the `permissions` key will run with all the permissions which can be given to a repository workflow.

## Recommendation

Add the `permissions` key to the workflow and set the permissions to the least privilege required to complete the task.

```yaml
name: "My workflow"
permissions:
  contents: read
  pull-requests: write
```
