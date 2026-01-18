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
