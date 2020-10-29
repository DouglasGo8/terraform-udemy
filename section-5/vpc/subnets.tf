
# Public Subnets
resource "aws_subnet" "main-public-1" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "main-public-1"
  }

}


resource "aws_subnet" "main-public-2" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"
  tags = {
    Name = "main-public-2"
  }

}

resource "aws_subnet" "main-public-3" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1c"
  tags = {
    Name = "main-public-3"
  }

}


# Private Subnets
resource "aws_subnet" "main-private-1" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1d"
  tags = {
    Name = "main-private-1"
  }

}

resource "aws_subnet" "main-private-2" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1e"
  tags = {
    Name = "main-private-2"
  }

}

resource "aws_subnet" "main-private-3" {
  vpc_id                  = "${aws_vpc.main-vpc.id}"
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1f"
  tags = {
    Name = "main-private-3"
  }

}


# Internet Gateway
resource "aws_internet_gateway" "main-gw" {

  vpc_id = "${aws_vpc.main-vpc.id}"
  tags = {
    Name = "main-gw"
  }
}



# Route Table Public
resource "aws_route_table" "main-route-public-1" {

  vpc_id = "${aws_vpc.main-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-gw.id}"
  }

  tags = {
    Name = "main-route-public-1"
  }
}


resource "aws_route_table_association" "main-route-public-assoc-1" {
  subnet_id      = "${aws_subnet.main-public-1.id}"
  route_table_id = "${aws_route_table.main-route-public-1.id}"
}


resource "aws_route_table_association" "main-route-public-assoc-2" {
  subnet_id      = "${aws_subnet.main-public-2.id}"
  route_table_id = "${aws_route_table.main-route-public-1.id}"
}


resource "aws_route_table_association" "main-route-public-assoc-3" {
  subnet_id      = "${aws_subnet.main-public-3.id}"
  route_table_id = "${aws_route_table.main-route-public-1.id}"
}
