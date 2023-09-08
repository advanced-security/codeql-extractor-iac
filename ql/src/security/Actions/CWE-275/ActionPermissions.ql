/**
 * @name Workflow does not contain permissions
 * @description Workflows should contain permissions to provide a clear understanding has permissions to run the workflow.
 * @kind problem
 * @problem.severity info
 * @precision medium
 * @id iac/actions/workflow-permissions
 * @tags actions
 *       maintainability
 *       external/cwe/cwe-275
 */

import iac

from Actions::Workflow workflow, Actions::Job job, YamlNode node
where
  job = workflow.getJob(_) and
  (
    not exists(workflow.lookup("permissions")) and
    not exists(job.lookup("permissions"))
  ) and
  node = job
select node, "Actions Job or Workflow does not set permissions"
