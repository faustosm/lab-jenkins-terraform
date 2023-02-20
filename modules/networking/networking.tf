resource "aws_vpc" "aws_vpc_example" {
    cidr_block = "10.0.0.0/16"

  tags = {
    Name = "example-vpc"
  }
}

resource "aws_subnet" "aws_subnet_example" {
  cidr_block = "10.0.0.0/16"
  vpc_id     = aws_vpc.aws_vpc_example.id
  
  tags = {
    Name = "aws_subnet_example"
  }
}
