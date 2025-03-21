private import iac

query predicate cloudformation(CloudFormation::Document n) { any() }

query predicate resources(CloudFormation::Resource n) { any() }

query predicate resourceProperties(CloudFormation::ResourceProperties n) { any() }

query predicate s3(CloudFormation::S3Bucket n) { any() }

query predicate s3Policy(CloudFormation::S3Bucket n, CloudFormation::S3BucketPolicy p) {
  p = n.getBucketPolicy()
}

query predicate lambda(CloudFormation::LambdaFunction n) { any() }

query predicate ec2SecurityGroup(CloudFormation::EC2SecurityGroup n) { any() }
query predicate ec2SecurityGroupIngress(CloudFormation::EC2SecurityGroupIngress n) { any() }
query predicate ec2SecurityGroupEgress(CloudFormation::EC2SecurityGroupEgress n) { any() }
query predicate iamRole(CloudFormation::IAMRole n) { any() }
query predicate iamStatement(CloudFormation::IAMStatement p){ any() }

query predicate ecsService(CloudFormation::ECSService p){ any() }
query predicate ecsCluster(CloudFormation::ECSCluster p){ any() }
query predicate ecsTaskSet(CloudFormation::ECSTaskSet p){ any() }
query predicate taskDefinition(CloudFormation::TaskDefinition p){ any() }
query predicate containerDefinition(CloudFormation::ContainerDefinition p){ any() }
