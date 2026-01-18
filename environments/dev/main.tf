module "network" {
  source = "../../modules/network"

  project_name = var.project_name
  location     = var.location
  environment  = var.environment
}

module "security" {
  source = "../../modules/security"

  project_name        = var.project_name
  location            = var.location
  environment         = var.environment
  resource_group_name = module.network.resource_group_name

  web_subnet_id = module.network.web_subnet_id
  app_subnet_id = module.network.app_subnet_id
  db_subnet_id  = module.network.db_subnet_id
}

module "compute" {
  source = "../../modules/compute"

  project_name        = var.project_name
  location            = var.location
  environment         = var.environment
  resource_group_name = module.network.resource_group_name

  web_subnet_id = module.network.web_subnet_id
  app_subnet_id = module.network.app_subnet_id

  admin_username = "azureuser"
  ssh_public_key = file("~/.ssh/id_rsa.pub")
}

module "data" {
  source = "../../modules/data"

  project_name        = var.project_name
  location            = var.location
  environment         = var.environment
  resource_group_name = module.network.resource_group_name

  sql_admin_username = "sqladminuser"
}

module "bastion" {
  source = "../../modules/bastion"

  project_name        = var.project_name
  location            = var.location
  environment         = var.environment
  resource_group_name = module.network.resource_group_name

  bastion_subnet_id = module.network.bastion_subnet_id
}

module "monitoring" {
  source = "../../modules/monitoring"

  project_name        = var.project_name
  location            = var.location
  environment         = var.environment
  resource_group_name = module.network.resource_group_name

  web_vm_id     = module.compute.web_vm_id
  app_vm_id     = module.compute.app_vm_id
  sql_server_id = module.data.sql_server_id
}

