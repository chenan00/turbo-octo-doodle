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

variable "base_workspace_path" {
    type        = string
    description = "Base workspace path"
}

variable "platform" {
    type        = string
    default     = "FiXo"
    description = "Platform type"
    validation {
        condition = (
            var.platform == "FiXo" || var.platform == "Storage"
        )
        error_message = "許可されていないプラットフォームタイプが指定されています。"
    }
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
    description = "preparation commands"
}

variable "shell_cmds" {
    type        = list(string)
    description = "shell commands to execute"
}

variable "revision" {
    type = string
}
