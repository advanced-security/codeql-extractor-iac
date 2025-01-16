/**
 * @name Egress without description
 * @kind problem
 * @problem.severity warning
 * @id iac/ec2/no-egress-description
 * @tags security
 *       aws
 *       cloudformation
 */

 //Unsure if this actually work, dobule check later on! Something might be fishy
import iac

from CloudFormation::EC2SecurityGroup sg 
//where sg.getEgressDesc().toString() = "null" or sg.getEgressDesc().toString() = "\"null\""
//where not exists(sg.getEgressDesc() )
select sg.getSgEgress(), "There is no description for the egress rule"
