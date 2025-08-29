resource "terraform_data" "revision" {
  input = var.revision
}

resource "terraform_data" "ssh" {
  lifecycle {
    create_before_destroy = true
    replace_triggered_by = [terraform_data.revision]
  }

  connection {
    type     = var.conn_type
    user     = var.conn_user
    host     = var.conn_host
    private_key = file(var.conn_private_key)
  }

  provisioner "remote-exec" {
    inline = var.prepare_cmds
  }

  provisioner "file" {
    source      = "${path.root}/srcs/storage-dev"
    destination = var.base_workspace_path
  }

  provisioner "file" {
    source      = "${path.root}/srcs/config/ceph_config_${lower(var.platform)}.yml"
    destination = "${var.base_workspace_path}/storage-dev/config/ceph_config.yml"
  }
  provisioner "remote-exec" {
    inline = var.platform == "FiXo" || var.platform == "Storage" ? var.shell_cmds : var.default_cmds
  }
}

output "revision-id" {
    value = terraform_data.revision
}

output "id" {
    value = terraform_data.ssh.id
}
