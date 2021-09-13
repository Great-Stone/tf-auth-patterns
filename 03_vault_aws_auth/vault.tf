data "vault_generic_secret" "cred" {
  path = "aws/creds/my-role"
}

output "vault_aws_cred" {
  value = nonsensitive(data.vault_generic_secret.cred.data)
}