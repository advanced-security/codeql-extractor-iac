/**
 * @name SG Ports as Range
 * @kind problem
 * @problem.severity warning
 * @id iac/ec2/ports-as-range
 * @tags security
 *       aws
 *       cloudformation
 */

import iac

from CloudFormation::EC2SecurityGroup sg
where not (sg.getIngressToPort().toString() = sg.getIngressFromPort().toString())
select sg.getIngressToPort(), "The security group should define a single port."
