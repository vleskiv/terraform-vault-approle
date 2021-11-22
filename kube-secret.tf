locals {
  value_roleid = vault_approle_auth_backend_role.this.role_id
  value_secretid = (
    length(vault_approle_auth_backend_role_secret_id.this) > 0 ?
    vault_approle_auth_backend_role_secret_id.this.0.secret_id :
    ""
  )
}

resource "kubernetes_secret" "my_secret" {
  metadata {
    name      = var.secret_name
    namespace = var.secret_ns
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
