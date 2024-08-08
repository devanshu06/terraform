terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.61"
    }
  }

  required_version = ">= 1.9.4"
}


provider "aws" {
  shared_config_files      = ["/home/one2n/.aws/config"]
  shared_credentials_files = ["/home/one2n/.aws/credentials"]
  profile = "default"
}