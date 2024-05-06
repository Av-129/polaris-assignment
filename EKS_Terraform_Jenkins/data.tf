data "aws_availability_zones" "az" {}

data "aws_eks_cluster" "polaris_cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "polaris_cluster_auth" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}