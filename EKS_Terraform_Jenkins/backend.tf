terraform {
  backend "s3" {
    bucket = "divyanshu-avasthi-polaris-assignment-bucket"
    key    = "eks-jenkins/terraform.tfstate"
    region = "ap-south-1"
  }
}