# AWS example

Deployment example for AWS only.

```hcl
# Variables
variable "aws_region" {
  default = "us-east-1"
}
# Terraform configuration
terraform {
  required_version = ">= 1.9.8"

  required_providers {
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
# Modules
module "mc_gatus" {
  source     = "terraform-aviatrix-modules/mc-gatus/aviatrix/aws"
  version    = "0.9.1"

  aws_region = var.aws_region
}
# Outputs
output "aws_dashboard" {
  value = module.mc_gatus.aws_dashboard_public_ip != null ? "http://${module.mc_gatus.aws_dashboard_public_ip}" : null
}
```
