# Actions Permissions not set to least privilege

Action jobs should be configured with the least privilege required to complete the task.
An Action job by default without the `permissions` key will run with all the permissions which can be given to a repository workflow.

## Recommendation

Add the `permissions` key to the job or workflow (for all jobs) and set the permissions to the least privilege required to complete the task.

```yaml
name: "My workflow"
permissions:
  contents: read
  pull-requests: write

# or
jobs:
  my-job:
    permissions:
      contents: read
      pull-requests: write
```
