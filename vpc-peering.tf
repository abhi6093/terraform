provider "aws" {
    region = "ap-northeast-3"
    }
    
resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "vpc2" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_vpc_peering_connection" "vpcpeering" {
  vpc_id      = aws_vpc.vpc1.id
  peer_vpc_id = aws_vpc.vpc2.id
  auto_accept = true
}

resource "aws_vpc_peering_connection_options" "appectingvpc" {
  vpc_peering_connection_id = aws_vpc_peering_connection.vpcpeering.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
   requester {
    allow_dns_resolution_from_remote_vpc = true
}