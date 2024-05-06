variable "vpc_cidr" {
  description = "Vpc CIDR"
  type        = string
}

variable "public_subnets" {
  description = "public subnets cidr"
  type        = list(string)
}
variable "private_subnets" {
  description = "private subnets cidr"
  type        = list(string)
}

variable "instance_type" {
  description = "EKs Nodes instance_type"
  type        = string
}
