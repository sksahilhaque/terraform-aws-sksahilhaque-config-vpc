variable "vpc_config" {
  description = "Set the CIDR block & name for the VPC"
  type = object({
    name   = string
    cidr   = string
    public = optional(bool, false) # Default to false if not specified
  })
  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr))
    error_message = "Invalid CIDR block format - ${var.vpc_config.cidr}"
  }
}

variable "subnet_config" {
  description = "Set the CIDR block & name for the subnets"
  type = map(object({
    name   = string
    cidr   = string
    azs    = string
    public = optional(bool, false) # Default to false if not specified
  }))
  validation {
    condition     = alltrue([for subnet in var.subnet_config : can(cidrnetmask(subnet.cidr))])
    error_message = "Invalid CIDR block format"
  }

}
