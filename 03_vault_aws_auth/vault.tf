// data "vault_generic_secret" "cred" {
//   path = "aws/creds/my-role"
// }

data "vault_aws_access_credentials" "tfc" {
  backend = "aws"
  type    = "sts"
  role    = "ec2_admin"
}

// output "vault_aws_cred" {
//   value = nonsensitive(data.vault_generic_secret.cred.data)
// }

output "vault_aws_sts" {
  value = data.vault_aws_access_credentials.tfc
}