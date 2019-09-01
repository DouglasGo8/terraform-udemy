

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "main-nat-gw-1" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.main-public-1.id}"
  depends_on    = ["aws_internet_gateway.main-gw"]
}


resource "aws_route_table" "main-route-private-1" {
  vpc_id = "${aws_vpc.main-vpc.id}"
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.main-nat-gw-1.id}"
  }
  tags = {
    Name = "main-private-1"
  }
}


resource "aws_route_table_association" "main-route-private-assoc-1" {
  subnet_id      = "${aws_subnet.main-private-1.id}"
  route_table_id = "${aws_route_table.main-route-private-1.id}"
}

resource "aws_route_table_association" "main-route-private-assoc-2" {
  subnet_id      = "${aws_subnet.main-private-2.id}"
  route_table_id = "${aws_route_table.main-route-private-1.id}"
}

resource "aws_route_table_association" "main-route-private-assoc-3" {
  subnet_id      = "${aws_subnet.main-private-3.id}"
  route_table_id = "${aws_route_table.main-route-private-1.id}"
}
