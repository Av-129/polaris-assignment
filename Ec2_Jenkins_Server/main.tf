module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "ec2_jenkins_vpc"
  cidr = var.vpc_cidr

  azs                     = data.aws_availability_zones.az.names
  public_subnets          = var.public_subnets
  enable_dns_hostnames    = true
  map_public_ip_on_launch = true


  tags = {
    Name        = "ec2_jenkins_vpc"
    Terraform   = "true"
    Environment = "dev"

  }

}

#Security Groups

module "sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ec2_jenkins_sg"
  description = "Security group for ec2_jenkins"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = {
    Name = "ec2_jenkins_sg"
  }
}


#ec2_jenkins

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name = "ec2_jenkins"

  instance_type               = var.instance_type
  key_name                    = "ec2-jenkins"
  monitoring                  = true
  vpc_security_group_ids      = [module.sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  availability_zone           = data.aws_availability_zones.az.names[0]
  user_data                   = file("user-data.sh")

  tags = {
    Name        = "ec2_jenkins"
    Terraform   = "true"
    Environment = "polaris"
  }
}