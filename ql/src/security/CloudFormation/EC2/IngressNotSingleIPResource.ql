/**
 * @name Single IP Ingress Resource
 * @kind problem
 * @problem.severity warning
 * @id iac/ec2/single-ip-ingress-resource
 * @tags security
 *       aws
 *       cloudformation
 */

import iac

from CloudFormation::EC2SecurityGroupIngress ingress
where not ingress.getCidrIp().toString().matches("%/32")
select ingress.getCidrIp(), "The security group should only allow traffic from one single IP address."
