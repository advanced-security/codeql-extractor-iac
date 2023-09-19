// Insecure
resource "aws_eks_cluster" "cluster" {
  name     = "my-cluster"
  role_arn = aws_iam_role.example.arn
  vpc_config {
    endpoint_public_access = true
  }
}

// Secure
resource "aws_eks_cluster" "cluster-secure" {
  name     = "cluster-secure"
  role_arn = aws_iam_role.example.arn
  encryption_config {
    provider  = "awskms"
    resources = ["secrets"]
  }
  vpc_config {
    endpoint_public_access = true
    public_access_cidrs    = ["10.2.0.0/8"]
  }
}
