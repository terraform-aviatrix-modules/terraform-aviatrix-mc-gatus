# Variables
variable "azure_region" {
  default = "East US"
}
# Terraform configuration
terraform {
  required_version = ">= 1.9.8"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.26"
    }
    terracurl = {
      source  = "devops-rob/terracurl"
      version = "~> 1.2.1"
    }
  }
}
# Providers
provider "azurerm" {
  features {}
}
# Modules
module "mc_gatus" {
  source       = "terraform-aviatrix-modules/mc-gatus/aviatrix/modules/azure"
  version      = "0.9.0"
  azure_region = var.azure_region
}
# Outputs
output "azure_dashboard" {
  value = module.mc_gatus.azure_dashboard_public_ip != null ? "http://${module.mc_gatus.azure_dashboard_public_ip}" : null
}
