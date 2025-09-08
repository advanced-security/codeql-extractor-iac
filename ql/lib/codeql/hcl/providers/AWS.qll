/**
 * Classes and predicates for analyzing AWS (Amazon Web Services) provider resources and configurations in HCL.
 * This module provides specific support for AWS resources, data sources, and provider configurations
 * commonly used in Terraform and other HCL-based infrastructure-as-code tools.
 */

private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants

/**
 * AWS provider module containing classes for analyzing AWS-specific HCL configurations.
 *
 * This module provides specialized classes for AWS resources like EC2 instances, S3 buckets,
 * RDS databases, and other AWS services commonly defined in Terraform configurations.
 */
module AWS {
  /**
   * An AWS resource in HCL configuration.
   *
   * AWS resources represent infrastructure components that are managed by AWS,
   * such as EC2 instances, S3 buckets, RDS databases, VPCs, etc.
   *
   * Example AWS resources:
   * ```
   * resource "aws_instance" "web" {
   *   ami           = "ami-12345678"
   *   instance_type = "t2.micro"
   * }
   *
   * resource "aws_s3_bucket" "data" {
   *   bucket = "my-data-bucket"
   * }
   * ```
   */
  class AwsResource extends Resource, Block {
    AwsResource() { this.getResourceType().regexpMatch("^aws.*") }
  }

  /**
   * An AWS provider configuration block.
   *
   * The AWS provider block configures authentication and regional settings
   * for AWS resource management in Terraform.
   *
   * Example AWS provider:
   * ```
   * provider "aws" {
   *   region     = "us-west-2"
   *   access_key = var.aws_access_key
   *   secret_key = var.aws_secret_key
   * }
   * ```
   */
  class AwsProvider extends Provider {
    AwsProvider() { this.getName() = "aws" }

    /** Gets the AWS region configuration expression. */
    Expr getRegion() { result = this.getAttribute("region") }

    /** Gets the AWS access key configuration expression. */
    Expr getAccessKey() { result = this.getAttribute("access_key") }

    /** Gets the AWS secret key configuration expression. */
    Expr getSecretKey() { result = this.getAttribute("secret_key") }
  }

  /**
   * An AWS S3 bucket resource.
   *
   * S3 buckets provide object storage with high availability and scalability.
   * They are commonly used for storing files, backups, static websites, and data lakes.
   *
   * Example S3 bucket:
   * ```
   * resource "aws_s3_bucket" "website" {
   *   bucket = "my-website-bucket"
   *
   *   tags = {
   *     Name        = "Website Bucket"
   *     Environment = "production"
   *   }
   * }
   * ```
   */
  class S3Bucket extends AwsResource {
    S3Bucket() { this.getResourceType() = "aws_s3_bucket" }

    override string getId() { result = this.getAttribute("bucket").(StringLiteral).getValue() }

    /**
     * Gets the ACL (Access Control List) configuration for this bucket.
     * This can be either a legacy attribute or a separate ACL resource.
     */
    Expr getAcl() {
      // Legacy attribute
      result = this.getAttribute("acl")
      or
      // New Block
      exists(S3BucketAcl acl | acl.getBucket() = this | result = acl)
    }

    /**
     * Gets the ACL value as a string (e.g., "private", "public-read").
     */
    string getAclValue() {
      result = this.getAcl().(StringLiteral).getValue()
      or
      result = this.getAcl().(S3BucketAcl).getAcl().(StringLiteral).getValue()
    }

    /**
     * Gets the logging configuration for this bucket.
     * This can be either a legacy attribute or a separate logging resource.
     */
    Expr getLogging() {
      // Legacy attribute
      result = this.getAttribute("logging")
      or
      // New Block
      exists(S3BucketLogging logs | logs.getBucket() = this | result = logs)
    }

    /**
     * Gets the versioning configuration for this bucket.
     * This can be either a legacy attribute or a separate versioning resource.
     */
    Expr getVersioning() {
      result = this.getAttribute("versioning")
      or
      exists(S3BucketVersioning versioning | versioning.getBucket() = this | result = versioning)
    }

    /**
     * Gets the versioning status as a boolean value.
     */
    boolean getVersioningValue() {
      result = this.getVersioning().(Block).getAttribute("enabled").(BooleanLiteral).getBool()
      or
      result =
        this.getVersioning().(S3BucketVersioning).getVersioningStatus().(BooleanLiteral).getBool()
    }

    /**
     * Gets the server-side encryption configuration for this bucket.
     * This can be either a legacy attribute or a separate encryption configuration resource.
     */
    Expr getEncryptionConfiguration() {
      result = this.getAttribute("server_side_encryption_configuration")
      or
      exists(S3BucketEncryptionConfiguration config | config.getBucket() = this | result = config)
    }
  }

  /**
   * An AWS S3 bucket logging configuration resource.
   *
   * This resource manages access logging for S3 buckets, allowing you to track
   * requests made to your bucket for security and audit purposes.
   *
   * Example S3 bucket logging:
   * ```
   * resource "aws_s3_bucket_logging" "example" {
   *   bucket = aws_s3_bucket.example.id
   *
   *   target_bucket = aws_s3_bucket.log_bucket.id
   *   target_prefix = "log/"
   * }
   * ```
   */
  class S3BucketLogging extends AwsResource {
    S3BucketLogging() { this.getResourceType() = "aws_s3_bucket_logging" }

    /** Gets the S3 bucket that this logging configuration applies to. */
    S3Bucket getBucket() { result = this.getAttribute("bucket") }
  }

  /**
   * An AWS S3 bucket ACL (Access Control List) configuration resource.
   *
   * This resource manages the access control list for S3 buckets, controlling
   * who can access your bucket and what permissions they have.
   *
   * Example S3 bucket ACL:
   * ```
   * resource "aws_s3_bucket_acl" "example" {
   *   bucket = aws_s3_bucket.example.id
   *   acl    = "private"
   * }
   * ```
   */
  class S3BucketAcl extends AwsResource {
    S3BucketAcl() { this.getResourceType() = "aws_s3_bucket_acl" }

    /** Gets the S3 bucket that this ACL configuration applies to. */
    S3Bucket getBucket() { result = this.getAttribute("bucket") }

    /** Gets the ACL setting expression. */
    Expr getAcl() { result = this.getAttribute("acl") }
  }

  /**
   * An AWS S3 bucket versioning configuration resource.
   *
   * This resource manages versioning settings for S3 buckets, allowing you to
   * keep multiple versions of objects in the same bucket.
   *
   * Example S3 bucket versioning:
   * ```
   * resource "aws_s3_bucket_versioning" "example" {
   *   bucket = aws_s3_bucket.example.id
   *   versioning_configuration {
   *     status = "Enabled"
   *   }
   * }
   * ```
   */
  class S3BucketVersioning extends AwsResource {
    S3BucketVersioning() { this.getResourceType() = "aws_s3_bucket_versioning" }

    /** Gets the S3 bucket that this versioning configuration applies to. */
    S3Bucket getBucket() { result = this.getAttribute("bucket") }

    /** Gets the versioning configuration block. */
    Block getVersioning() { result = this.getAttribute("versioning") }

    /** Gets the versioning status expression. */
    Expr getVersioningStatus() { result = this.getVersioning().getAttribute("enabled") }
  }

  /**
   * An AWS S3 bucket server-side encryption configuration resource.
   *
   * This resource manages encryption settings for S3 buckets, ensuring that
   * objects stored in the bucket are encrypted at rest.
   *
   * Example S3 bucket encryption:
   * ```
   * resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
   *   bucket = aws_s3_bucket.example.id
   *
   *   rule {
   *     apply_server_side_encryption_by_default {
   *       sse_algorithm = "AES256"
   *     }
   *   }
   * }
   * ```
   */
  class S3BucketEncryptionConfiguration extends AwsResource {
    S3BucketEncryptionConfiguration() {
      this.getResourceType() = "aws_s3_bucket_server_side_encryption_configuration"
    }

    /** Gets the S3 bucket that this encryption configuration applies to. */
    S3Bucket getBucket() { result = this.getAttribute("bucket") }
  }

  /**
   * An AWS RDS database instance resource.
   *
   * RDS provides managed relational database services for various database engines
   * like MySQL, PostgreSQL, Oracle, SQL Server, and others.
   *
   * Example RDS database:
   * ```
   * resource "aws_db_instance" "main" {
   *   identifier = "main-database"
   *   engine     = "mysql"
   *   engine_version = "8.0"
   *   instance_class = "db.t3.micro"
   *   allocated_storage = 20
   *
   *   db_name  = "myapp"
   *   username = "admin"
   *   password = var.db_password
   * }
   * ```
   */
  class Database extends AwsResource {
    Database() { this.getResourceType() = "aws_db_instance" }

    /** Gets the database password expression. */
    Expr getPassword() { result = this.getAttribute("password") }
  }

  /**
   * An AWS Elastic Kubernetes Service (EKS) cluster resource.
   *
   * EKS provides managed Kubernetes clusters, making it easier to run Kubernetes
   * applications on AWS without needing to install and operate your own cluster.
   *
   * Example EKS cluster:
   * ```
   * resource "aws_eks_cluster" "main" {
   *   name     = "main-cluster"
   *   role_arn = aws_iam_role.cluster.arn
   *   version  = "1.21"
   *
   *   vpc_config {
   *     subnet_ids = var.subnet_ids
   *   }
   * }
   * ```
   */
  class EKSCluster extends AwsResource {
    EKSCluster() { this.getResourceType() = "aws_eks_cluster" }

    /** Gets the VPC configuration block for this EKS cluster. */
    Block getVpcConfig() { result = this.getAttribute("vpc_config") }

    /** Gets whether the cluster endpoint has public access enabled. */
    boolean getEndpointPublicAccess() {
      result = this.getVpcConfig().getAttribute("endpoint_public_access").(BooleanLiteral).getBool()
    }

    /** Gets the CIDR blocks that can access the public cluster endpoint. */
    Expr getPublicAccessCidrs() { result = this.getVpcConfig().getAttribute("public_access_cidrs") }

    /** Gets the public access sources configuration. */
    Expr getPublicAccessSources() {
      result = this.getVpcConfig().getAttribute("public_access_sources")
    }

    /** Gets the encryption configuration for this cluster. */
    Expr getEncryptionConfig() { result = this.getAttribute("encryption_config") }
  }

  /**
   * An AWS EKS cluster encryption configuration.
   *
   * This configuration enables envelope encryption of Kubernetes secrets using
   * AWS Key Management Service (KMS) keys.
   *
   * Example EKS encryption configuration:
   * ```
   * resource "aws_eks_cluster" "main" {
   *   name = "main-cluster"
   *
   *   encryption_config {
   *     provider {
   *       key_arn = aws_kms_key.cluster.arn
   *     }
   *     resources = ["secrets"]
   *   }
   * }
   * ```
   */
  class EKSClusterEncryptionConfig extends AwsResource {
    private EKSCluster cluster;

    EKSClusterEncryptionConfig() { this = cluster.getAttribute("encryption_config") }

    /** Gets the list of resources to be encrypted (e.g., "secrets"). */
    Expr getResources() { result = this.getAttribute("resources") }
  }
}
