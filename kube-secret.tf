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
  description = ""
  type        = string
  default     = ""
}

variable "vault_addr" {
  description = ""
  type        = string
  default     = "http://localhost:8200"
}

locals {
  secret_ns   = "default"
  secret_name = "mysecret"
  value_roleid = vault_approle_auth_backend_role.this.role_id
  value_secretid = (
    length(vault_approle_auth_backend_role_secret_id.this) > 0 ?
    vault_approle_auth_backend_role_secret_id.this.0.secret_id :
    ""
  )
}

resource "kubernetes_secret" "my_secret" {
  metadata {
    name      = local.secret_name
    namespace = local.secret_ns
  }
  type = "Opaque"
  data = {
    VAULTS: templatefile(var.template_path, 
                        { vault_url        = var.vault_addr, 
                          name_roleid      = var.name_roleid, 
                          value_roleid     = local.value_roleid, 
                          create_secret_id = var.create_secret_id, 
                          name_secretid    = var.name_secretid, 
                          value_secretid   = local.value_secretid } )
  }
  depends_on = [vault_approle_auth_backend_role.this]
}
