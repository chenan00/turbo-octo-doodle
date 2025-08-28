locals {
  config_path = "${path.root}/srcs/config/ceph_config_${var.platform}.yml"
  cmds-prepare = var.prepare_cmds
  cmds-fixo = var.shell_cmds
}

resource "terraform_data" "ssh" {
  connection {
    type     = var.conn_type
    user     = var.conn_user
    host     = var.conn_host
    private_key = file(var.conn_private_key)
  }

  provisioner "remote-exec" {
    inline = local.cmds-prepare
  }

  provisioner "file" {
    source      = "${path.root}/srcs/storage-dev"
    destination = var.base_workspace_path
  }

  provisioner "file" {
    source      = local.config_path
    destination = "${var.base_workspace_path}/config/ceph_config.yml"
  }
  provisioner "remote-exec" {
    inline = var.platform == "fixo" || var.platform == "fixo2" ? local.cmds-fixo: var.default_cmds
  }
}
