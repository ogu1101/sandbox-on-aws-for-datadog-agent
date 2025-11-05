terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    datadog = {
      source = "DataDog/datadog"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region

  default_tags {
    tags = {
      name    = "created by ${var.creator}"
      team    = var.team
      creator = var.creator
    }
  }
}

# Configure the Datadog provider
provider "datadog" {
  api_key = var.dd_api_key
  app_key = var.dd_app_key
}
