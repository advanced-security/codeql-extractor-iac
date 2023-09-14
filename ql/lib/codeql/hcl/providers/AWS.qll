private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants

module AWS {
  /**
   * AWS resources.
   */
  class AwsResource extends Resource, Block {
    AwsResource() { this.getResourceType().regexpMatch("^aws.*") }
  }

  /**
   * AWS provider.
   */
  class AwsProvider extends Provider {
    AwsProvider() { this.getName() = "aws" }

    Expr getRegion() { result = this.getAttribute("region") }

    Expr getAccessKey() { result = this.getAttribute("access_key") }

    Expr getSecretKey() { result = this.getAttribute("secret_key") }
  }

  /**
   * AWS S3 Bucket.
   */
  class S3Bucket extends AwsResource {
    S3Bucket() { this.getResourceType() = "aws_s3_bucket" }

    override string getId() { result = this.getAttribute("bucket").(StringLiteral).getValue() }

    /**
     * Get the ACL attribute (legacy) or acl resource (new).
     */
    Expr getAcl() {
      // Legacy attribute
      result = this.getAttribute("acl")
      or
      // New Block
      exists(S3BucketAcl acl | acl.getBucket() = this | result = acl)
    }

    /**
     * Get the ACL value as a string.
     */
    string getAclValue() {
      result = this.getAcl().(StringLiteral).getValue()
      or
      result = this.getAcl().(S3BucketAcl).getAcl().(StringLiteral).getValue()
    }

    /**
     * Get the logging attribute (legacy) or logging resource (new).
     */
    Expr getLogging() {
      // Legacy attribute
      result = this.getAttribute("logging")
      or
      // New Block
      exists(S3BucketLogging logs | logs.getBucket() = this | result = logs)
    }

    /**
     * Get the versioning attribute (legacy) or versioning resource (new).
     */
    Expr getVersioning() {
      result = this.getAttribute("versioning")
      or
      exists(S3BucketVersioning versioning | versioning.getBucket() = this | result = versioning)
    }

    /**
     * Get the versioning value as a boolean.
     */
    boolean getVersioningValue() {
      result = this.getVersioning().(Block).getAttribute("enabled").(BooleanLiteral).getBool()
      or
      result =
        this.getVersioning().(S3BucketVersioning).getVersioningStatus().(BooleanLiteral).getBool()
    }

    /**
     * Get the encryption configuration attribute (legacy) or encryption configuration resource (new).
     */
    Expr getEncryptionConfiguration() {
      result = this.getAttribute("server_side_encryption_configuration")
      or
      exists(S3BucketEncryptionConfiguration config | config.getBucket() = this | result = config)
    }
  }

  /**
   * AWS S3 Bucket Logging.
   */
  class S3BucketLogging extends AwsResource {
    S3BucketLogging() { this.getResourceType() = "aws_s3_bucket_logging" }

    S3Bucket getBucket() { result = this.getAttribute("bucket") }
  }

  /**
   * AWS S3 Bucket ACL.
   */
  class S3BucketAcl extends AwsResource {
    S3BucketAcl() { this.getResourceType() = "aws_s3_bucket_acl" }

    S3Bucket getBucket() { result = this.getAttribute("bucket") }

    Expr getAcl() { result = this.getAttribute("acl") }
  }

  /**
   * AWS S3 Bucket Versioning.
   */
  class S3BucketVersioning extends AwsResource {
    S3BucketVersioning() { this.getResourceType() = "aws_s3_bucket_versioning" }

    S3Bucket getBucket() { result = this.getAttribute("bucket") }

    Block getVersioning() { result = this.getAttribute("versioning") }

    Expr getVersioningStatus() { result = this.getVersioning().getAttribute("enabled") }
  }

  /**
   * AWS S3 Bucket Encryption Configuration.
   */
  class S3BucketEncryptionConfiguration extends AwsResource {
    S3BucketEncryptionConfiguration() {
      this.getResourceType() = "aws_s3_bucket_server_side_encryption_configuration"
    }

    S3Bucket getBucket() { result = this.getAttribute("bucket") }
  }

  /**
   * AWS Database.
   */
  class Database extends AwsResource {
    Database() { this.getResourceType() = "aws_db_instance" }

    Expr getPassword() { result = this.getAttribute("password") }
  }
}
