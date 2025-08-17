output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.my_vpc.id

}

output "subnet_ids" {
  description = "A map of subnet IDs"
  value = { for k, v in aws_subnet.public_subnet : k => { "subnet_id" : v.id, "availability_zone" : v.availability_zone }
  }

}



