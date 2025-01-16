/**
 * @name SG ports as range resource
 * @kind problem
 * @problem.severity warning
 * @id iac/ec2/ports-as-range-resource
 * @tags security
 *       aws
 *       cloudformation
 */

import iac

from CloudFormation::EC2SecurityGroupIngress ingress 
where not (ingress.getToPort().toString() = ingress.getFromPort().toString())
select ingress.getFromPort(), "The security group should define a single port."
