resource "aws_subnet" "public-subnet-1" {
    vpc_id = "${aws_vpc.projectvpc.id}"
    cidr block = "${var.subnet_cidr}
    map_public_ip_on_launch = true
  availability_zone = "ap-northeast-3"
tags = {
  Name = "public-subnet-1"
}
}

resource "aws_subnet" "public-subnet-2"
  vpc_id = "${aws_vpc.projectvpc.id}"
  cidr block = "${var.subnet1_cidr}"
  map_public_ip_on_launch = true
  availabilit_zone = "ap-northeast-3"
  tags = {
    Name = "public-subnet-2"
  }

  # Creating 1st application subnet 
resource "aws_subnet" "application-subnet-1" {
  vpc_id                  = "${aws_vpc.projectvpc.id}"
  cidr_block             = "${var.subnet2_cidr}"
  map_public_ip_on_launch = false
  availability_zone = "ap-northeast-3"
tags = {
  Name = "Application Subnet 1"
}
}
# Creating 2nd application subnet 
resource "aws_subnet" "application-subnet-2" {
  vpc_id                  = "${aws_vpc.projectvpc.id}"
  cidr_block             = "${var.subnet3_cidr}"
  map_public_ip_on_launch = false
  availability_zone = "ap-northeast-3"
tags = {
  Name = "Application Subnet 2"
}
}
# Create Database Private Subnet
resource "aws_subnet" "private-subnet-1" {
  vpc_id            = "${aws_vpc.projectvpc.id}"
  cidr_block        = "${var.subnet4_cidr}"
  availability_zone = "ap-northeast-3"
tags = {
  Name = "Database Subnet 1"
}
}
# Create Database Private Subnet
resource "aws_subnet" "private-subnet-2" {
  vpc_id            = "${aws_vpc.projectvpc.id}"
  cidr_block        = "${var.subnet5_cidr}"
  availability_zone = "ap-northeast-3"
tags = {
  Name = "Database Subnet 1"
}
}