/**
 * @name Cidr too broad
 * @kind problem
 * @problem.severity warning
 * @id iac/ec2/cidr-too-broad
 * @tags security
 *       aws
 *       cloudformation
 */

import iac

from CloudFormation::EC2SecurityGroup sg 
where sg.getEgressCidrIp().toString() = "0.0.0.0/0" or sg.getEgressCidrIp().toString() = "\"0.0.0.0/0\""
select sg.getEgressCidrIp(), "CIDR range is too broad"
