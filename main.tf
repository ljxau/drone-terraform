provider "aws" {
  version = "~> 1.32"
  region  = "${var.aws_region}"
}

provider "random" {
  version = "~> 1.3"
}

terraform {
  backend "s3" {}
}

#############################################################
# Data sources to get VPC and default security group details
#############################################################
data "aws_vpc" "default" {
  default = true
}
