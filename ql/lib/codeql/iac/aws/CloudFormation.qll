private import codeql.iac.YAML
private import codeql.files.FileSystem

/**
 * AWS CloudFormation.
 */
module CloudFormation {
  /**
   * An AWS CloudFormation Variable node.
   *
   * This is used as a base class for other CloudFormation nodes that can be
   * referenced by other nodes.
   */
  abstract class Variable extends YamlNode {
    abstract string getName();

    override string toString() { result = "CloudFormation Variable `" + this.getName() + "`" }
  }

  /**
   * Find a CloudFormation variable by reference node.
   */
  Variable findByReference(YamlNode node) {
    exists(Variable vars |
      // Same file reference
      vars.getFile().getAbsolutePath() = node.getFile().getAbsolutePath() and
      (
        // Support for JSON References
        vars.getName() = node.(YamlMapping).lookup("Ref").(YamlString).getValue()
        or
        // Support for YAML References
        vars.getName() = node.(YamlScalar).getValue()
      )
    |
      result = vars
    )
  }

  /**
   * An AWS CloudFormation file node.
   */
  class Document extends YamlNode, YamlDocument, YamlMapping {
    Document() { exists(this.lookup("AWSTemplateFormatVersion")) }

    override string toString() { result = "CloudFormation Document" }

    Resource getResources() { result = this.lookup("Resources").getAChild() }

    Output getOutputs() { result = this.lookup("Outputs").getAChild() }
  }

  /**
   * An AWS CloudFormation Resource node.
   */
  class Resource extends Variable, YamlNode, YamlMapping {
    private Document document;

    Resource() { this = document.lookup("Resources").getAChild() }

    override string toString() { result = "CloudFormation Resource" }

    override string getName() {
      exists(YamlNode pair, string key_name |
        pair = this.getParentNode().(YamlMapping).getChild(_) and
        key_name = pair.(YamlString).getValue()
      |
        result = pair.toString()
      )
    }

    /**
     * Get the resource type.
     */
    string getType() { result = this.lookup("Type").(YamlString).getValue() }

    /**
     * Get the resource properties.
     */
    ResourceProperties getProperties() { result = this.lookup("Properties") }
  }

  /**
   * An AWS CloudFormation Resource Properties node.
   */
  class ResourceProperties extends YamlNode, YamlMapping {
    private Resource resource;

    ResourceProperties() { this = resource.lookup("Properties") }

    override string toString() { result = "CloudFormation Resource Properties" }

    /**
     * Get the resource property value.
     */
    YamlNode getProperty(string key) { result = this.lookup(key) }
  }

  /**
   * An AWS CloudFormation Outputs node.
   */
  class Output extends YamlNode, YamlMapping {
    private Document document;

    Output() { this = document.lookup("Outputs").getAChild() }

    override string toString() { result = "CloudFormation Outputs" }
  }

  /**
   * An AWS CloudFormation S3 Bucket.
   */
  class S3Bucket extends Resource {
    S3Bucket() { this.getType() = "AWS::S3::Bucket" }

    override string toString() { result = "CloudFormation S3 Bucket" }

    /**
     * Get Bucket Policy if it exists.
     */
    S3BucketPolicy getBucketPolicy() {
      exists(S3BucketPolicy policies | policies.getBucket() = this | result = policies)
    }

    /**
     * Get the bucket access control.
     */
    string getAccessControl() {
      result = this.getProperties().getProperty("AccessControl").(YamlString).getValue()
    }
  }

  /**
   * An AWS CloudFormation S3 Bucket Policy.
   */
  class S3BucketPolicy extends Resource {
    S3BucketPolicy() { this.getType() = "AWS::S3::BucketPolicy" }

    override string toString() { result = "CloudFormation S3 Bucket Policy" }

    /**
     * Get the bucket policy.
     */
    YamlNode getBucket() {
      result = findByReference(this.getProperties().getProperty("Bucket"))
      // exists(Variable node, S3Bucket buckets |
      //   node = this.getProperties().getProperty("Bucket") and
      //   // Support for JSON References
      //   exists(YamlMapping map | map = node |
      //     buckets.getName() = map.lookup("Ref").(YamlString).getValue()
      //   )
      //   or
      //   // Support for YAML References
      //   exists(YamlScalar scalar | scalar.getValue().matches("^!Ref .*$") |
      //     buckets.getName() = scalar.getValue()
      //   )
      // |
      //   result = buckets
      // )
    }
  }
  class LambdaFunction extends Resource {
    LambdaFunction() { this.getType() = "AWS::Lambda::Function" }

    override string toString() { result = "CloudFormation Lambda Function" }

    /**
     * Get the Lambda function runtime.
     */
    string getRuntime() {
      result = this.getProperties().getProperty("Runtime").(YamlString).getValue()
    }
    /**
     * get principal
     */
    string getPrincipal() {
      result = this.getProperties().getProperty("Principal").(YamlString).getValue()
    }

  }

  class EC2SecurityGroup extends Resource {
    EC2SecurityGroup() { this.getType() = "AWS::EC2::SecurityGroup" }

    override string toString() { result = "CloudFormation EC2 Security Group" }

    /**
     * Get the security group egress rules.
     */
    YamlNode getSgEgress() {
      result = this.getProperties().getProperty("SecurityGroupEgress")
    }
    YamlNode getEgressCidrIp() {
      result = this.getSgEgress().getAChildNode().(YamlMapping).lookup("CidrIp")
    }
    YamlNode getEgressFromPort() {
      result = this.getSgEgress().getAChildNode().(YamlMapping).lookup("FromPort")
    }
    YamlNode getEgressToPort() {
      result = this.getSgEgress().getAChildNode().(YamlMapping).lookup("ToPort")
    }
    YamlNode getEgressDesc() {
      result = this.getSgEgress().getAChildNode().(YamlMapping).lookup("Description")
    }

    /**
     * Get the security group ingress rules.
     */
    YamlNode getSgIngress() {
      result = this.getProperties().getProperty("SecurityGroupIngress")
    }
    YamlNode getIngressCidrIp() {
      result = this.getSgIngress().getAChildNode().(YamlMapping).lookup("CidrIp")
    }
    YamlNode getIngressFromPort() {
      result = this.getSgIngress().getAChildNode().(YamlMapping).lookup("FromPort")
    }
    YamlNode getIngressToPort() {
      result = this.getSgIngress().getAChildNode().(YamlMapping).lookup("ToPort")
    }
    YamlNode getIngressDesc() {
      result = this.getSgIngress().getAChildNode().(YamlMapping).lookup("Description")
    }
  }

  class EC2SecurityGroupEgress extends Resource {
    EC2SecurityGroupEgress() { this.getType() = "AWS::EC2::SecurityGroupEgress" }

    override string toString() { result = "CloudFormation EC2 Security Group Egress" }

    /**
     * Get the security group ingress CIDR IP.
     */
    YamlNode getCidrIp() {
      result = this.getProperties().getProperty("CidrIp")
    }

    /**
     * Get the security group ingress from port.
     */
    YamlNode getFromPort() {
      result = this.getProperties().getProperty("FromPort")
    }
    YamlNode getToPort() {
      result = this.getProperties().getProperty("ToPort")
    }
  }



  class EC2SecurityGroupIngress extends Resource {
    EC2SecurityGroupIngress() { this.getType() = "AWS::EC2::SecurityGroupIngress" }

    override string toString() { result = "CloudFormation EC2 Security Group Ingress" }

    /**
     * Get the security group ingress CIDR IP.
     */
    YamlNode getCidrIp() {
      result = this.getProperties().getProperty("CidrIp")
    }

    /**
     * Get the security group ingress from port.
     */
    YamlNode getFromPort() {
      result = this.getProperties().getProperty("FromPort")
    }
    YamlNode getToPort() {
      result = this.getProperties().getProperty("ToPort")
    }
  }

  class IAMRole extends Resource {
    IAMRole() { this.getType() = "AWS::IAM::Role" }

    override string toString() { result = "CloudFormation IAM Role" }

    string getProperty(string key) { result = this.getProperties().getProperty(key).toString() }

    /**
     * Get the IAM role policies.
     */
    IAMStatement getPolicy() {
      result = this.getProperties().getProperty("Policies").getAChild().getAChild()

      /*
      exists(YamlNode policies 
        | policies = this.getProperties().getAChildNode()  
        | result = policies and policies.toString() = "Statement" )
 */
    }
  }
  class IAMStatement extends YamlNode {
    IAMStatement(){ this.getAChild().toString() = "Statement"}

    YamlNode getAction() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("Action")
    }
    YamlNode getEffect() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("Effect")
    }
    YamlNode getResource() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("Resource")
    }
  }

  class ECSService extends Resource {
    ECSService() { this.getType() = "AWS::ECS::Service" }
    YamlNode getNetworkConfiguration() {
      result = this.getProperties().getProperty("NetworkConfiguration")
    }

    /**
     * Get ecs service platform version
     */
    YamlNode getPlatformVersion() {
      result = this.getProperties().getProperty("PlatformVersion")
    }

    TaskDefinition getTaskDefinition() {
      result = this.getProperties().getProperty("TaskDefinition")
    }
  }

  class ECSTaskSet extends Resource {
    ECSTaskSet() { this.getType() = "AWS::ECS::TaskSet" }

    override string toString() { result = "CloudFormation ECS Task Set" }

    /**
     * Get the task set network configuration.
     */
    YamlNode getNetworkConfiguration() {
      result = this.getProperties().getProperty("NetworkConfiguration")
    }

     YamlNode getAssignPublicIp() {
      result = this.getNetworkConfiguration().getAChild().(YamlMapping).lookup("AssignPublicIp")
     }
  }

  class ECSNetworkConfiguration extends YamlNode {
    ECSNetworkConfiguration() { this.getAChild().toString() = "NetworkConfiguration" }

    YamlNode getAwsvpcConfiguration() {
      result = this.getAChild().(YamlMapping).lookup("AwsvpcConfiguration")
    }
    YamlNode getAssignPublicIp() {
      result = this.getAwsvpcConfiguration().(YamlMapping).lookup("AssignPublicIp")
    }
  }

  class TaskDefinition extends Resource {
    TaskDefinition() { this.getType() = "AWS::ECS::TaskDefinition" }

    override string toString() { result = "CloudFormation ECS Task Definition" }

    /**
     * Get the task definition container definitions.
     */
    ContainerDefinition getContainerDefinitions() {
      result = this.getProperties().getProperty("ContainerDefinitions")
    }
    /**
     * Get network mode
     */
    YamlNode getNetworkMode() {
      result = this.getProperties().getProperty("NetworkMode")
    }

    /**
     * get PidMode
     * 
     */
    YamlNode getPidMode() {
      result = this.getProperties().getProperty("PidMode")
    }
    /**
     * get IPCMode
     */
    YamlNode getIpcMode() {
      result = this.getProperties().getProperty("IpcMode")
    }
    /**
     * get Volumes
     */
    YamlNode getVolumes() {
      result = this.getProperties().getProperty("Volumes")
    }
    /**
     * get PlacementConstraints
     */
    YamlNode getPlacementConstraints() {
      result = this.getProperties().getProperty("PlacementConstraints")
    }
    /**
     * get RequiresCompatibilities
     */
    YamlNode getRequiresCompatibilities() {
      result = this.getProperties().getProperty("RequiresCompatibilities")
    }
    /**
     * get Cpu
     */
    YamlNode getCpu() {
      result = this.getProperties().getProperty("Cpu")
    }
    /**
     * get Memory
     */
    YamlNode getMemory() {
      result = this.getProperties().getProperty("Memory")
    }
    /**
     * get ExecutionRoleArn
     */
    YamlNode getExecutionRoleArn() {
      result = this.getProperties().getProperty("ExecutionRoleArn")
    }

    /**
     * get logConfiguration
     */
    YamlNode getLogConfiguration() {
      result = this.getProperties().getProperty("LogConfiguration")
    }

    /**
     * get Secrets from ContainerDefinitions
     */
    YamlNode getSecrets() {
      result = this.getContainerDefinitions().getAChild().(YamlMapping).lookup("Secrets")
    }
    YamlNode getRuntimePlatform() {
      result = this.getProperties().getProperty("RuntimePlatform").(YamlMapping).lookup("OperatingSystemFamily")
    }
  }

  class ECSCluster extends Resource {
    ECSCluster() { this.getType() = "AWS::ECS::Cluster" }

    override string toString() { result = "CloudFormation ECS Cluster" }
    
    /** checks if container insights is enabled in container settings */
    YamlNode getContainerInsights() {
      result = this.getProperties().getProperty("ClusterSettings").getAChild().(YamlMapping).lookup("Value")
    }
  }

  class ContainerDefinition extends YamlNode 
  {
    ContainerDefinition() { this.getAChild().toString() = "ContainerDefinitions" }

    YamlNode getName() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("Name")
    }

    YamlNode getNetworkConfiguration() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("NetworkConfiguration")
    }
    YamlNode getnetworkconfigurationAwsvpcConfiguration() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("AwsvpcConfiguration")
    }
    YamlNode getImage() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("Image")
    }
    YamlNode getMemory() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("Memory")
    }
    YamlNode getMemoryReservation() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("MemoryReservation")
    }
    YamlNode getCpu() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("Cpu")
    }
    YamlNode getEssential() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("Essential")
    }
    YamlNode getPortMappings() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("PortMappings")
    }
    YamlNode getVolumesFrom() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("VolumesFrom")
    }
    YamlNode getEnvironment() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("Environment")
    }
    YamlNode getSecrets() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("Secrets")
    }
    YamlNode getLogConfiguration() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("LogConfiguration")
    }
    YamlNode getHealthCheck() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("HealthCheck")
    }
    YamlNode getEntryPoint() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("EntryPoint")
    }
    YamlNode getCommand() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("Command")
    }
    YamlNode getWorkingDirectory() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("WorkingDirectory")
    }
    string getPrivileged() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("Privileged").toString() 
    }

    string getReadOnlyRootFilesystem() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("ReadOnlyRootFilesystem").toString()
    }
    YamlNode getLinuxParametersCapabilities() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("LinuxParameters")
    }

    YamlNode getUser() {
      result = this.getAChild().getAChild().(YamlMapping).lookup("User")
    }
  }

}