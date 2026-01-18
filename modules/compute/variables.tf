variable "project_name" { type = string }
variable "location" { type = string }
variable "environment" { type = string }

variable "resource_group_name" { type = string }

variable "web_subnet_id" { type = string }
variable "app_subnet_id" { type = string }

variable "admin_username" { type = string }
variable "ssh_public_key" { type = string }
