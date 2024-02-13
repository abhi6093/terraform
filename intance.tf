provider "aws" {
region = "ap-northeast-1"
}

resource "aws_security_group" "my_sg_group" {
    name = "my-first-sg"
    description = "allow-ssh and http"
    vpc_id = var.vpc_id
    ingress {
        protocol = "TCP"
        from_port = "22"
        to_port = "22"
        cidr_blocks = ["0.0.0.0/0"]  
     }
     ingress {
        protocol = "TCP"
        from_port = "80"
        to_port = "80"
        cidr_blocks = ["0.0.0.0/0"]
     }
     egress {
        protocol = "-1"
        from_port = 0
        to_port = 0 
        cidr_blocks = ["0.0.0.0/0"]
     }
}
resource "aws_instance" "my_instance" {
    ami = var.image_id
    instance_type = var.machine_type
    key_name = "terraform_key"
    vpc_security_group_ids = ["sg-011d824db10ce7685", aws_security_group.my_sg_group.id]
    tags = {
        name = "my-instance"
        env = "dev"
    }
}

resource "aws_instance" "another_instance" {
    ami = var.image_id
    instance_type = var.machine_type
    key_name = "terraform_key"
    vpc_security_group_ids = ["sg-011d824db10ce7685"]
    tags = {
        name = "another_instance"
        env = "dev"
    }
}
variable "image_id" {
    default = "ami-05ff0b3a7128cd6f8"
}

variable "machine_type" {
    default = "t2.micro"
}

variable "vpc_id" {
    default = "vpc-0810f9a3bdda84e56"
}