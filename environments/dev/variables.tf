variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type      = string
  sensitive = true

}

variable "project_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}
