terraform {
  required_providers {
    azurerm = {
      source  = "azurerm"
      version = "4.40.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id   =  "6fc13d10-c1bf-4274-8d91-68859a20ab08"
  tenant_id         = "129d979e-2acc-4867-8f4f-950622f47afb"
}
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_linux_web_app" "web_app" {
  app_settings                                   = {
    MYSQL_HOST     = azurerm_mysql_flexible_server.mysql_server.fqdn
    MYSQL_DB       = azurerm_mysql_flexible_database.mysql_db.name
    MYSQL_USER     = "${azurerm_mysql_flexible_server.mysql_server.administrator_login}@${azurerm_mysql_flexible_server.mysql_server.name}"
    MYSQL_PASSWORD = var.mysql_admin_password
  }
  client_affinity_enabled                        = true
  client_certificate_enabled                     = false
  client_certificate_mode                        = "Required"
  enabled                                        = true
  ftp_publish_basic_authentication_enabled       = false
  https_only                                     = true
  location                                       = "francecentral"
  name                                           = var.web_app_name
  public_network_access_enabled                  = true
  resource_group_name                            = azurerm_resource_group.rg.name
  service_plan_id                                = azurerm_service_plan.app_plan.id 
  tags                                           = {
    "created by " = "hssaini hamza"
  }
  virtual_network_backup_restore_enabled         = false
  vnet_image_pull_enabled                        = false
  webdeploy_publish_basic_authentication_enabled = true
  site_config {
    always_on                                     = true
    app_command_line                              = "\n\n"
    container_registry_use_managed_identity       = false
    default_documents                             = ["Default.htm", "Default.html", "Default.asp", "index.htm", "index.html", "iisstart.htm", "default.aspx", "index.php", "hostingstart.html"]
    ftps_state                                    = "FtpsOnly"
    health_check_path                             = "/health"
    health_check_eviction_time_in_min             = 5
    http2_enabled                                 = true
    load_balancing_mode                           = "LeastRequests"
    local_mysql_enabled                           = false
    managed_pipeline_mode                         = "Integrated"
    minimum_tls_version                           = "1.2"
    remote_debugging_enabled                      = false
    remote_debugging_version                      = "VS2022"
    scm_minimum_tls_version                       = "1.2"
    scm_use_main_ip_restriction                   = false
    use_32_bit_worker                             = true
    vnet_route_all_enabled                        = false
    websockets_enabled                            = false
    worker_count                                  = 1
    application_stack {
      node_version             = "20-lts"
    }
  }
}
resource "azurerm_service_plan" "app_plan" {
  location                        = var.location
  maximum_elastic_worker_count    = 1
  name                            = var.app_service_plan_name
  os_type                         = "Linux"
  per_site_scaling_enabled        = false
  premium_plan_auto_scale_enabled = false
  resource_group_name             = azurerm_resource_group.rg.name
  sku_name                        = "B1"
  tags = {
    "created by " = "hssaini hamza"
  }
  worker_count           = 1
  zone_balancing_enabled = false
}
resource "azurerm_mysql_flexible_server" "mysql_server" {
  administrator_login               = var.mysql_admin_user
  administrator_password            = var.mysql_admin_password
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  location                          = var.location
  name                              = var.mysql_flexible_server
  public_network_access             = "Enabled"
  resource_group_name               = azurerm_resource_group.rg.name
  sku_name                          = "B_Standard_B1ms"
  tags                              = {
    "created by " = "hssaini hamza"
  }
  version                           = "8.0.21"
  zone                              = ""
  storage {
    auto_grow_enabled   = true
    io_scaling_enabled  = false
    iops                = 396
    log_on_disk_enabled = false
    size_gb             = 32
  }
}
resource "azurerm_mysql_flexible_database" "mysql_db" {
  name                = var.mysql_database_name
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.mysql_server.name
  charset             = "utf8"
  collation           = "utf8_general_ci"
}