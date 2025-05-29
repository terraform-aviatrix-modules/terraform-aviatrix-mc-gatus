# All supported clouds example

Deployment example of all supported clouds.

```hcl
variable "aws_region" { default = "us-east-1" }
variable "azure_region" { default = "East US" }

provider "aws" {
  region = var.aws_region
}

provider "azurerm" {
  features {}
}

module "mc_gatus" {
  source       = "terraform-aviatrix-modules/mc-gatus/aviatrix"
  version       = "0.9.1"

  aws_region   = var.aws_region
  azure_region = var.azure_region
}

output "aws_dashboard" {
  value = module.mc_gatus.aws_dashboard_public_ip != null ? "http://${module.mc_gatus.aws_dashboard_public_ip}" : null
}
output "azure_dashboard" {
  value = module.mc_gatus.azure_dashboard_public_ip != null ? "http://${module.mc_gatus.azure_dashboard_public_ip}" : null
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.94"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.26"
    }
    terracurl = {
      source  = "devops-rob/terracurl"
      version = "~> 1.2.1"
    }
  }
  required_version = ">= 1.9.8"
}
```
