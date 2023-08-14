/**
 * @name Elastic Search Logging Disabled
 * @description Elastic Search Logging Disabled
 * @kind problem
 * @problem.severity error
 * @security-severity 6.0
 * @precision high
 * @id hcl/aws/elastic-search-disabled-logging
 * @tags security
 */

import hcl

from Resource r
where
  r.getResourceType() = "aws_elasticsearch_domain" and
  // Disabled by default (in-secure), if present the default if turned on (secure)
  not r.hasAttribute("log_publishing_options")
  or
  exists(Block block |
    block = r.getAttribute("log_publishing_options") and
    r.getAttribute("enabled").(BooleanLiteral).getBool() = false and
    block = r
  )
select r, "Logging Disabled"
