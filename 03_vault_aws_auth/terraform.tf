data "tfe_organization" "org" {
  name = "snapshot-auth"
}

resource "tfe_workspace" "ws" {
  name         = "04_dynamic"
  organization = data.tfe_organization.org.name
}

resource "tfe_variable" "access_key" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = data.vault_generic_secret.cred.data.access_key
  category     = "env"
  workspace_id = tfe_workspace.ws.id
  description  = "aws access key from vault"
}

resource "tfe_variable" "secret_key" {
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = data.vault_generic_secret.cred.data.secret_key
  category     = "env"
  workspace_id = tfe_workspace.ws.id
  sensitive    = true
  description  = "aws access key from vault"
}