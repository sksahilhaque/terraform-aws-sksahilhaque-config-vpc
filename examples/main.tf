resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_config.cidr
  tags = {
    Name = var.vpc_config.name
  }

}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.my_vpc.id

  for_each          = var.subnet_config # accept key= subnet name & value = subnet config {cidr, azs}
  cidr_block        = each.value.cidr
  availability_zone = each.value.azs

  tags = {
    Name = each.key
  }
}

locals {
  public_subnet = {
    for key, value in var.subnet_config : key => value if value.public
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  count  = length(local.public_subnet) > 0 ? 1 : 0

}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.my_vpc.id
  count  = length(local.public_subnet) > 0 ? 1 : 0
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }

}

resource "aws_route_table_association" "main" {
  for_each       = local.public_subnet
  subnet_id      = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.route_table[0].id

}
