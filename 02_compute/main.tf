locals {
  tags = {
    Owner        = "gslee"
    Region       = var.region
    Purpose      = "Snapshot"
    TTL          = 72
    Terraform    = true
    TFE          = true
    TFEWorkspace = "snapshot-auth/network"
  }
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.58.0"
    }
  }
}

provider "aws" {
  region                  = var.region
  access_key              = var.access_key
  secret_key              = var.secret_key

  default_tags {
    tags = local.tags
  }
}

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket"
  acl    = "private"
}

// resource "aws_instance" "example" {
//   ami           = "ami-0b50511490117e709" // ubuntu 18.04 LTS
//   instance_type = "t2.micro"
// }