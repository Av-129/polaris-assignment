module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks_jenkins_vpc"
  cidr = var.vpc_cidr

  azs                  = data.aws_availability_zones.az.names
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true


  tags = {
    "kubernetes.io/cluster/ploaris-eks" = "shared"
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/ploaris-eks" = "shared"
    "kubernetes.io/role/elb"               = 1

  }
  private_subnet_tags = {
    "kubernetes.io/cluster/ploaris-eks" = "shared"
    "kubernetes.io/role/private_elb"       = 1

  }

}


#EKS cluster module

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "ploaris-eks"
  cluster_version = "1.29"

  cluster_endpoint_public_access = false
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets

  eks_managed_node_groups = {

    nodes = {
      min_size      = 3
      max_size      = 5
      desired_size  = 3
      instance_type = var.instance_type
    }
  }

  tags = {
    Environment = "polaris"
    Terraform   = "true"
  }
}



