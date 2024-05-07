// create a bucket in aws account inorder to use remote backend. It will be used to maintain the terraform state files
terraform {
  backend "s3" {
    bucket = "divyanshu-avasthi-polaris-assignment-bucket"
    key    = "eks-jenkins/terraform.tfstate"
    region = "ap-south-1"
  }
}