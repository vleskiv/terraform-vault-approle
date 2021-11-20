variable "role_key_name" {
  description = "secret id: name of the key to be used in kubernetes secret"
  type        = string
  default     = "secretid"
}

variable "secret_key_name" {
  description = "role id: name of the key to be used in kubernetes secret"
  type        = string
  default     = "roleid"
}

locals {
  secret_ns   = "default"
  secret_name = "mysecret"
}

resource "kubernetes_secret" "my_secret" {
  metadata {
    name      = local.secret_name
    namespace = local.secret_ns
  }
  type = "Opaque"
  data = {
    var.role_key_name = vault_approle_auth_backend_role.this.role_id
  }
  depends_on = [vault_approle_auth_backend_role.this]
}
