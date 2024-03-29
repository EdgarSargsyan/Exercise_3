
# Configure the AWS Provider
provider "aws" {
  region = var.aws_region_tf
}

terraform {
  backend "s3" {
    bucket = "esargsyan-terraform-state-bucket"
    key    = "tfstate/state"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


