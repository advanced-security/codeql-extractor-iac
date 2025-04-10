/**
 * @name ECS Fargate services should run on the latest Fargate platform version
 * @kind problem
 * @problem.severity warning
 * @id iac/ecs/latest-version
 * @tags security
 *       experimental
 *       aws/ecs/10
 *       NIST/800-53/SI-2
 *       NIST/800-53/SI-2(2)
 *       NIST/800-53/SI-2(4)
 *       NIST/800-53/SI-2(5)
 *       PCI-DSS/4.0.1
 *       PCI-DSS/6.3.3
 * 
 */

// need to figure out how to make !Ref to be recognized, then and this should be possible to be used properly, used as "Experimental for now
import iac
from CloudFormation::ECSService ecs, CloudFormation::TaskDefinition td
//where ecs.getPlatformVersion().toString() = ["'LATEST'", "'1.4.0'"] or ecs.getPlatformVersion().toString() = ["'LATEST'", "'1.0.0'"]
//where td.getRuntimePlatform().toString() = "'LINUX'" or td.getRuntimePlatform().toString() = "'WINDOWS'"
where
        ((ecs.getPlatformVersion().toString() = ["'LATEST'", "'1.4.0'"] or not exists(ecs.getPlatformVersion())) 
        and 
        (td.getRuntimePlatform().toString() ="'LINUX'" or not exists(td.getRuntimePlatform())) )
        or 
        ((ecs.getPlatformVersion().toString() = ["'LATEST'", "'1.0.0'"] or not exists(ecs.getPlatformVersion())) 
        and 
        (exists(td.getRuntimePlatform()) and td.getRuntimePlatform().toString() !="'LINUX'"))

select td, "ContainerDefinitions must have a log configuration"

