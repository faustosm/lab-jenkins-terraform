

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.31.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}



module "Netwoking" {
    source = "./modules/networking" 
}

module "Compute" {
    source = "./modules/compute"
    subnet_id = module.Netwoking.id  
}

module "Notifications" {
    source = "./modules/notifications"  
}