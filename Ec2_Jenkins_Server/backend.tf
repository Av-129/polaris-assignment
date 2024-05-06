terraform {
  backend "s3" {
    bucket = "divyanshu-avasthi-polaris-assignment-bucket"
    key    = "ec2-jenkins/terraform.tfstate"
    region = "ap-south-1"
  }
}