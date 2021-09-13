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
  // access_key              = var.access_key
  // secret_key              = var.secret_key

  default_tags {
    tags = local.tags
  }
}

resource "aws_security_group" "example" {
  name        = "example"
  description = "Allow SSH port from all"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}