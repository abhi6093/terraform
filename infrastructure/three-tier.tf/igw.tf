# Creating Internet Gateway 
resource "aws_internet_gateway" "projectgateway" {
  vpc_id = "${aws_vpc.projectvpc.id}"
}