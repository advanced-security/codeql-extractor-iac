/**
 * @name Azure Security Center Disabled Notifications
 * @description Azure Security Center Disabled Notifications
 * @kind problem
 * @problem.severity error
 * @security-severity 3.0
 * @precision high
 * @id hcl/azure/security-center-disabled-notifications
 * @tags security
 */

import hcl

from Azure::SecurityCenterContact contact
where
  contact.getAlertNotifications() = false and
  contact.getAlertsToAdmins() = false
select contact, "disabled notifications"
