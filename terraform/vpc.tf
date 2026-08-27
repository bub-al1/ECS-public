
resource "aws_vpc" "vpctest" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnettest" {
  vpc_id     = aws_vpc.vpctest.id
  cidr_block = "10.0.1.0/24"
   map_public_ip_on_launch = true             
  availability_zone       = "eu-north-1a"      
  }
resource "aws_subnet" "subnettest2" {
  vpc_id     = aws_vpc.vpctest.id
  cidr_block = "10.0.2.0/24"
   map_public_ip_on_launch = true            
  availability_zone       = "eu-north-1b"      
  }


resource "aws_internet_gateway" "igwtest" {
  vpc_id = aws_vpc.vpctest.id
}

resource "aws_route_table" "routepubtoigw" {
  vpc_id = aws_vpc.vpctest.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igwtest.id
    }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnettest.id
  route_table_id = aws_route_table.routepubtoigw.id
}
resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.subnettest2.id
  route_table_id = aws_route_table.routepubtoigw.id
}
