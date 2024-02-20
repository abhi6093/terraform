provider "aws" {
    region ="ap-northeast-3"
}

resource "aws_vpc"  "project-vpc" {
    cidr blocks = "${var.vpc_cidr}"
    instance_tenancy = "default"

    tags = {
        Name = "project-vpc"
    }
}