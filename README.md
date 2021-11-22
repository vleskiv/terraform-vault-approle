# Vault AppRole Terraform module

Terraform module which creates Vault AppRole and Kubernetes secret

## Usage

```hcl
module "approle" {
  source = "github.com/vleskiv/terraform-vault-approle.git?ref=task"

  role_name   = "mySuperApp"
  policy_name = "mySuperApp"
  policy      = <<EOT
  path "secret/data/mySuperApp" {
    capabilities = ["read","list","update"]
  }
  EOT

  create_secret_id = false
  template_path   = "templates/secret-value.json.tpl"
  vault_addr = var.vault_addr
}
```

## Import current approle

```sh
terraform import module.approle.vault_approle_auth_backend_role.this auth/approle/role/mySuperApp
terraform import module.approle.vault_policy.this mySuperApp
terraform show
# Copy your policies in current module
terraform plan -out tfplan

      ~ policies                = [
          - "mySuperApp",
        ]

      ~ token_policies          = [
          + "mySuperApp",
        ]

  + resource "vault_approle_auth_backend_role_secret_id" "this" {
      + accessor          = (known after apply)
      + backend           = "approle"
      + id                = (known after apply)
      + role_name         = "mySuperApp"
      + secret_id         = (sensitive value)
      + wrapping_accessor = (known after apply)
      + wrapping_token    = (sensitive value)
    }

# vault_approle_auth_backend_role_secret_id will be added anyway because
# resource vault_approle_auth_backend_role_secret_id doesn't support import
terraform apply tfplan
```

## Requirements

| Name | Version |
|------|---------|
| terraform | 0.14.4 |
| vault | ~> 2.8 |
| kubernetes |   |

## Providers

| Name | Version |
|------|---------|
| vault | ~> 2.8 |
| kubernetes |   |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_secret\_id | Create secret\_id | `bool` | `false` | no |
| enable\_login | Enable login feature | `bool` | `false` | no |
| policy | Vault policy | `string` | n/a | yes |
| policy\_name | Name for Vault policy | `string` | n/a | yes |
| role\_name | Name for AppRole | `string` | n/a | yes |
| secret\_id\_num\_uses | The number of times any particular SecretID can be used to fetch a token from this AppRole, after which the SecretID will expire. A value of zero will allow unlimited uses. | `number` | `0` | no |
| secret\_id\_ttl | The number of seconds after which any SecretID expires | `number` | `0` | no |
| token\_explicit\_max\_ttl | If set, will encode an explicit max TTL onto the token in number of seconds. This is a hard cap even if token\_ttl and token\_max\_ttl would otherwise allow a renewal. | `number` | `0` | no |
| token\_max\_ttl | The maximum lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time. | `number` | `0` | no |
| token\_num\_uses | The period, if any, in number of seconds to set on the token. | `number` | `0` | no |
| token\_period | If set, indicates that the token generated using this role should never expire. The token should be renewed within the duration specified by this value. At each renewal, the token's TTL will be set to the value of this field. Specified in seconds. | `number` | `0` | no |
| name\_roleid | name of the key to be used in kubernetes secret | `string` | `secretid` | no |
| name\_secretid | name of the key to be used in kubernetes secret | `string` | `secretid` | no |
| template\_path | Path to the template file | `string` | `` | yes |
| vault\_addr | Vault address e.g. `http://localhost:8200` | `string` | `` | yes |
| secret\_name | Name of the Kubernetes secret | `string` | `mysecret` | no |
| secret\_ns | Name of the kubernetes namespace | `string` | `default` | no |


## Outputs

| Name | Description |
|------|-------------|
| policy\_id | The policy ID |
| role\_id | The role ID of created approle |
| secret\_id | The secret ID of created approle |
