import iac

abstract class PasswordSinks extends Expr { }

class AzurePasswords extends PasswordSinks {
  AzurePasswords() { exists(Azure::Database db | this = db.getAdministratorPassword()) }
}

class AwsPasswords extends PasswordSinks {
  AwsPasswords() {
    exists(AWS::AwsProvider provider, AWS::Database db |
      this = db.getPassword() or this = provider.getAccessKey() or this = provider.getSecretKey()
    )
  }
}
