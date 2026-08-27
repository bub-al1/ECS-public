terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
  bucket         = "abudev-ecs-fargate"
  key            = "terraform/state"
  region         = "eu-north-1"
  dynamodb_table = "abudev-tflock"
  }
}

provider "aws" {
  region = "eu-north-1"
}

