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
    key = vault_approle_auth_backend_role.this.role_id
  }

  depends_on = [vault_approle_auth_backend_role.this]
}
