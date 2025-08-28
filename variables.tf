variable "base_workspace_path" {
    type        = string
    description = "Base workspace path"
    default     = "/home/henry/"
}

variable "conn_type" {
    type        = string
    description = "connection type"
    default = "ssh"
}
variable "conn_user" {
    type        = string
    description = "connection user"
    default = "root"
}
variable "conn_host" {
    type        = string
    description = "connection host"
}
variable "conn_private_key" {
    type        = string
    description = "connection private key"
    sensitive   = true
}

variable "platform" {
    type        = string
    default     = "fixo"
    description = "Platform type"
}

variable "default_cmds" {
    type = list(string)
    default = [
      "echo 'Nothing to do!'"
    ]
    description = "default commands"
}

variable "prepare_cmds" {
    type = list(string)
    default = [
      "rm -rf /home/henry/storage-dev",
    ]
    description = "preparation commands"
}

variable "shell_cmds" {
  description = "shell commands to execute"
  type        = list(string)
}
