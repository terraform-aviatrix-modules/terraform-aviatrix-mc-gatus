# Variables
variable "aws_region" {
  default = "us-east-1"
}
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
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.94"
    }
    terracurl = {
      source  = "devops-rob/terracurl"
      version = "~> 1.2.1"
    }
  }
}
# Providers
provider "aws" {
  region = var.aws_region
}
provider "azurerm" {
  features {}
}

# Modules
module "mc_gatus" {
  source       = "terraform-aviatrix-modules/mc-gatus/aviatrix"
  version      = "0.9.1"
  aws_region   = var.aws_region
  azure_region = var.azure_region
}
# Outputs
output "aws_dashboard" {
  value = module.mc_gatus.aws_dashboard_public_ip != null ? "http://${module.mc_gatus.aws_dashboard_public_ip}" : null
}
output "azure_dashboard" {
  value = module.mc_gatus.azure_dashboard_public_ip != null ? "http://${module.mc_gatus.azure_dashboard_public_ip}" : null
}
