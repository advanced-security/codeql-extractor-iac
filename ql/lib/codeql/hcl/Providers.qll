/**
 * Classes and predicates for analyzing cloud provider resources and configurations in HCL.
 * This module imports provider-specific implementations for major cloud platforms and services
 * commonly used in Terraform and other infrastructure-as-code tools.
 *
 * Supported providers include:
 * - AWS (Amazon Web Services) - EC2, S3, RDS, EKS, and other AWS services
 * - Azure (Microsoft Azure) - Virtual machines, storage accounts, databases, and Azure services
 * - GCP (Google Cloud Platform) - Compute Engine, Cloud Storage, GKE, and other GCP services
 * - GitHub - Repository management, actions, and GitHub-specific resources
 * - Kubernetes - Kubernetes cluster resources and configurations
 * - Helm - Helm chart deployments and package management
 * - OCI (Oracle Cloud Infrastructure) - Oracle cloud services and resources
 * - Alicloud (Alibaba Cloud) - Alibaba cloud platform services
 */

import providers.Alicloud
import providers.AWS
import providers.Azure
import providers.GCP
import providers.GitHub
import providers.Helm
import providers.Kubernetes
import providers.OCI
