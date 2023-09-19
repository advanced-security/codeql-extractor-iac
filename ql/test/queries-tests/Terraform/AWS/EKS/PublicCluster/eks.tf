// Insecure
resource "aws_eks_cluster" "cluster" {
  name = "my-cluster"
  vpc_config {
    endpoint_public_access = true
  }
}

// Secure
resource "aws_eks_cluster" "cluster-secure" {
  name = "cluster-secure"
  vpc_config {
    endpoint_public_access = true
    public_access_cidrs    = ["10.2.0.0/8"]
  }
}
