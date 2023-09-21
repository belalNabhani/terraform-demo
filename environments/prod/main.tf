terraform {
  backend "" {

  }

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "env" {
  description = "environment variable"
  type = "string"
}

locals {
  description = ""
  type = ""
}

module "web_app" {
  source = "../modules/web_app"

  # input varialbes
  env = var.env
  variable = 'value'
}