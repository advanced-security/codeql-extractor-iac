private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants
private import codeql.hcl.Terraform::Terraform


module AzureSecurityCenter {
  private import codeql.hcl.providers.Azure

  /**
   * Azure Security Center Contact.
   */
  class SecurityCenterContact extends Azure::AzureResource {
    SecurityCenterContact() { this.getResourceType() = "azurerm_security_center_contact" }

    string getEmail() { result = this.getAttribute("email").(StringLiteral).getValue() }

    boolean getAlertNotifications() {
      result = this.getAttribute("alert_notifications").(BooleanLiteral).getBool()
    }

    boolean getAlertsToAdmins() {
      result = this.getAttribute("alerts_to_admins").(BooleanLiteral).getBool()
    }
  }
}