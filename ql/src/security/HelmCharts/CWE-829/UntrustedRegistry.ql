/**
 * @name Untrusted Registry used in Helm Chart
 * @description Untrusted Registry used in Helm Chart
 * @kind problem
 * @problem.severity warning
 * @security-severity 9.0
 * @precision high
 * @id helmcharts/kubernetes/untrusted-registry
 * @tags security
 *       helmchart
 *       external/cwe/cwe-829
 *       experimental
 */

import iac

bindingset[regs]
private predicate allowedRegistries(string regs) {
  exists(string reg |
    reg in [
        // Docker Hub
        "docker\\.io",
        // GitHub Container Registry
        "ghcr\\.io",
        // Amazon ECR
        "[A-Za-z0-9]+\\.dkr\\.ecr\\.[A-Za-z0-9-]+\\.amazonaws\\.com",
        // Azure Container Registry
        "azurecr\\.io",
        // Google Container Registry
        "gcr\\.io",
      ]
  |
    regs.regexpMatch("^" + reg + "/%")
  )
}

from HelmChart::Container container
where
  not container.getImage().matches("%/%")
  or
  not allowedRegistries(container.getImage())
select container.lookup("image"), "untrusted container registry"
