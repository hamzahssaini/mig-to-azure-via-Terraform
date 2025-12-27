variable "resource_group_name" {
  description = "Name of the resource group where resources will be deployed"
  type        = string
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
}
variable "web_app_name" {
  description = "Name of the Linux Web App"
  type        = string
}
variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "mysql_flexible_server" {
  description = "Name of the MySQL Server"
  type        = string
}

variable "mysql_database_name" {
  description = "Name of the MySQL database"
  type        = string
}

variable "app_service_plan_sku" {
  description = "SKU for App Service Plan"
  type        = string
}


# -------------------------------
# MySQL Flexible Server variables
# -------------------------------
variable "mysql_admin_user" {
  description = "Admin username for MySQL Flexible Server"
  type        = string
}

variable "mysql_admin_password" {
  description = "Admin password for MySQL Flexible Server"
  type        = string
  sensitive   = true
}