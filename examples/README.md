# This is a complete usage to work with this terraform module.

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
