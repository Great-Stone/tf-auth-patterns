terraform {
  required_providers {
    tfe = {
      source = "hashicorp/tfe"
      version = ">= 0.26.1"
    }
    vault = {
      source = "hashicorp/vault"
      version = ">= 2.23.0"
    }
  }
}

provider "tfe" {
  hostname = var.hostname
  token    = var.tf_token
}

provider "vault" {
  address = "http://172.28.128.11:8200"
  token = var.vault_token
}
