terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.31.0"
    }
  }
}

provider "aws" {
  # Configuration options
}



module "Netwoking" {
    source = "./modules/networking" 
}

module "Compute" {
      source = "./modules/compute"
      //subnet_id = module.Netwoking.saida
}

module "Notifications" {
    source = "./modules/notifications"  
}