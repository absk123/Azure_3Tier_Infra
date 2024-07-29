terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.113.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "backendrg-ResourceGroup"  
    storage_account_name = "abcd1234"                      
    container_name       = "tfstate"                      
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {  }
}