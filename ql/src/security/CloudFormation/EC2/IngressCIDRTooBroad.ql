/**
 * @name Ingress SG Too Broad
 * @kind problem
 * @problem.severity warning
 * @id iac/ec2/ingress-sg-too-broad
 * @tags security
 *       aws
 *       cloudformation
 */

import iac

from CloudFormation::EC2SecurityGroup sg 
where sg.getIngressCidrIp().toString() = "0.0.0.0/0" or sg.getIngressCidrIp().toString() = "\"0.0.0.0/0\""
select sg.getIngressCidrIp(), "Ingress"
