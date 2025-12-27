# -------------------------------
# Web App Outputs
# -------------------------------
output "web_app_name" {
  description = "Name of the Linux Web App"
  value       = azurerm_linux_web_app.web_app.name
}

output "web_app_url" {
  description = "Default URL of the Web App"
  value       = "https://${azurerm_linux_web_app.web_app.default_hostname}"
}

# -------------------------------
# MySQL Server Outputs
# -------------------------------
output "mysql_server_name" {
  description = "Name of the MySQL Flexible Server"
  value       = azurerm_mysql_flexible_server.mysql_server.name
}

output "mysql_server_fqdn" {
  description = "Fully qualified domain name of the MySQL server"
  value       = azurerm_mysql_flexible_server.mysql_server.fqdn
}

output "mysql_admin_user" {
  description = "MySQL administrator username"
  value       = azurerm_mysql_flexible_server.mysql_server.administrator_login
  sensitive   = true
}

output "mysql_database_name" {
  description = "Name of the MySQL database"
  value       = azurerm_mysql_flexible_database.mysql_db.name
}
