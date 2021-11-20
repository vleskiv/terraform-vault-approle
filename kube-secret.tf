variable "key_name_secretid" {
  description = "secret id: name of the key to be used in kubernetes secret"
  type        = string
  default     = "secretid"
}

variable "key_name_roleid" {
  description = "role id: name of the key to be used in kubernetes secret"
  type        = string
  default     = "roleid"
}

locals {
  secret_ns   = "default"
  secret_name = "mysecret"
#  secret_keys = concat(aws_instance.blue.*.id, aws_instance.green.*.id)
  value_secretid = (
    length(vault_approle_auth_backend_role_secret_id.this) > 0 ?
    vault_approle_auth_backend_role_secret_id.this.0.secret_id :
    null
  )
}

resource "kubernetes_secret" "my_secret" {
  metadata {
    name      = local.secret_name
    namespace = local.secret_ns
  }
  type = "Opaque"
  data = {
    (var.key_name_roleid)   = vault_approle_auth_backend_role.this.role_id
    (var.key_name_secretid) = local.value_secretid
  }
  depends_on = [vault_approle_auth_backend_role.this]
}


#  dynamic "secret_key" {
#    for_each = [{"name" : "key1",  "value" : "val1"},{"name" : "key2",  "value" : "val2"}]
#    content {
#      secret_key.name = secret_key.value
#    }


