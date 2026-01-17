module "network" {
  source = "../../modules/network"

  project_name = var.project_name
  location     = var.location
  environment  = var.environment
}
