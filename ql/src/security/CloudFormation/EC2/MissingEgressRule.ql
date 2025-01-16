/**
 * @name Missing Egress 
 * @kind problem
 * @problem.severity warning
 * @id iac/ec2/missing-egress
 * @tags security
 *       aws
 *       cloudformation
 */

import iac

from CloudFormation::EC2SecurityGroup sg 
where not exists(sg.getSgEgress())
select sg, "Missing egress rule."
