provider "aws" {
region = "ap-northeast-3"
}
resource "aws_instance" "my_instance" {
    ami = var.image_id
    instance_type = var.machine_type
    key_name = "terraform_key"
    vpc_security_group_ids = ["sg-011d824db10ce7685"]
}

variable "image_id" {
    default = "ami-05ff0b3a7128cd6f8"
}

variable "machine_type" {
    default = "t2.micro"
}