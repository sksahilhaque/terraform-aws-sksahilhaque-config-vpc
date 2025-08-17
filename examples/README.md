# AWS VPC Terraform Module

This Terraform module creates a VPC with customizable network configuration in AWS.

## Features

- Creates a VPC with specified CIDR block
- Creates public and private subnets across multiple availability zones
- Configures internet gateway for public subnets
- Sets up NAT gateways for private subnets
- Configures route tables and associations
- Enables DNS hostnames and DNS support

## Usage

```
provider "aws" {
  region = "your region name"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_config = {
    name = "your vpc name"
    cidr = "10.0.0.0/16"
  }

  subnet_config = {
    public_subnet = {
      name   = "your public subnet name"
      cidr   = "10.0.1.0/24"
      azs    = "your availability zone"

      # Default subnet is private to make it public set public = true
      public = false
    }

    private_subnet = {
      name = "your private subnet name"
      cidr = "10.0.3.0/24"
      azs  = "your availability zone"
    }
  }
}
```
