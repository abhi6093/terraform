provider "aws" {
region = "ap-northeast-3"
}
resource "aws_instance" "my_instance" {
    ami = "ami-05ff0b3a7128cd6f8"
    instance_type = "t2.micro"
    key_name = "terraform_key"
    vpc_security_group_ids = ["sg-011d824db10ce7685"]
}