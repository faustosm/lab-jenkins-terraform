resource "aws_vpc" "vpc_example" {
  cidr_block = "10.0.0.0/16"
    tags = {
    Name = "vpc_example"
  }
}

resource "aws_subnet" "subnet_private_example" {
  vpc_id     = aws_vpc.vpc_example.id
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "subnet_private_example"
  }
}