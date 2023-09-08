/**
 * @name HTTP scheme is allowed
 * @description HTTP scheme is allowed
 * @kind problem
 * @severity warning
 * @security-severity 2.0
 * @precision very-high
 * @id iac/openapi/http-allowed
 * @tags security
 */

import iac

from OpenApi::Document oapi
where oapi.getSchemes() = "http"
select oapi.lookup("schemes"), "http scheme is not secure"
