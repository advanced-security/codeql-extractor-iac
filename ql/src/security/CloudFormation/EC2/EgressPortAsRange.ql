/**
 * @name Port Range 
 * @description Ports defined as range
 * @kind problem
 * @problem.severity warning
 * @id cf/aws/ports-as-range
 * @tags security
 *       aws
 *       cloudformation
 */

import iac

from CloudFormation::EC2SecurityGroup sg 
where not sg.getEgressToPort() = sg.getEgressFromPort()
select sg.getEgressToPort(), "Port should not be defined as range"
