/**
 * @name Ingress sg too broad for resource
 * @kind problem
 * @problem.severity warning
 * @id iac/ec2/ingress-sg-broad-resource
 * @tags security
 *       aws
 *       cloudformation
 */

import iac

from CloudFormation::EC2SecurityGroupIngress ingress
where ingress.getProperties().getProperty("CidrIp").toString() = "0.0.0.0/0"
select ingress.getProperties().getProperty("CidrIp"), "The security group should define clear ranges from where incoming traffic is allowed."
