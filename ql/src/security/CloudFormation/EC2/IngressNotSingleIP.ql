/**
 * @name Ingress not single ip
 * @kind problem
 * @problem.severity warning
 * @id iac/ec2/ingress-single-ip
 * @tags security
 *       aws
 *       cloudformation
 */

import iac

from CloudFormation::EC2SecurityGroup sg 
where not sg.getIngressCidrIp().toString().matches("%/32")
select sg.getIngressCidrIp(), "The security group should only allow traffic from one single IP address."
