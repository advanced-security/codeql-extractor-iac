private import iac

query predicate cloudformation(CloudFormation::Document n) { any() }

query predicate resources(CloudFormation::Resource n) { any() }

query predicate resourceProperties(CloudFormation::ResourceProperties n) { any() }
