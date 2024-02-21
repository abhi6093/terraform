
resource "aws_vpc"  "projectvpc" {
    cidr blocks = "${var.vpc_cidr}"
    instance_tenancy = "default"

    tags = {
        Name = "project-vpc"
    }
}