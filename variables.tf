variable "role_name" {
  type        = string
  description = "Name for AppRole"
}

variable "policy" {
  type        = string
  description = "Vault policy"
}

variable "policy_name" {
  type        = string
  description = "Name for Vault policy"
}

variable "secret_id_ttl" {
  type        = number
  default     = 0
  description = "The number of seconds after which any SecretID expires"
}

variable "token_max_ttl" {
  type        = number
  default     = 0
  description = "The maximum lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time."
}

variable "secret_id_num_uses" {
  type        = number
  default     = 0
  description = "The number of times any particular SecretID can be used to fetch a token from this AppRole, after which the SecretID will expire. A value of zero will allow unlimited uses."
}

variable "token_explicit_max_ttl" {
  type        = number
  default     = 0
  description = "If set, will encode an explicit max TTL onto the token in number of seconds. This is a hard cap even if token_ttl and token_max_ttl would otherwise allow a renewal."
}

variable "token_num_uses" {
  type        = number
  default     = 0
  description = "The period, if any, in number of seconds to set on the token."
}

variable "token_period" {
  type        = number
  default     = 0
  description = "If set, indicates that the token generated using this role should never expire. The token should be renewed within the duration specified by this value. At each renewal, the token's TTL will be set to the value of this field. Specified in seconds."
}

variable "enable_login" {
  type        = bool
  description = "Enable login feature"
  default     = false
}

variable "create_secret_id" {
  type        = bool
  description = "Create secret_id"
  default     = false
}

# Kube secret variables
variable "name_secretid" {
  description = "secret id: name of the key to be used in kubernetes secret"
  type        = string
  default     = "secretid"
}

variable "name_roleid" {
  description = "role id: name of the key to be used in kubernetes secret"
  type        = string
  default     = "roleid"
}
variable "template_path" {
  description = "Path to the template file"
  type        = string
  default     = ""
}

variable "vault_addr" {
  description = "Vault address"
  type        = string
  default     = ""
}

variable "secret_name" {
  description = "Name of the Kubernetes secret"
  type        = string
  default     = "mysecret"
}

variable "secret_ns" {
  description = "Name of the kubernetes namespace"
  type        = string
  default     = "default"
}