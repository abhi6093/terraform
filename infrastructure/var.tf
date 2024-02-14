variable "vpc_cidr" {
    default = "192.168.0.0/16"
}

variable "private_subnet_cidr" {
    default = "192.168.0.0/20"
}

variable "public_subnet_cidr" {
    default = "192.168.16.0/20"
}

variable "project" {
    default = "cloudblitz"
}

variable "env" {
    default = "dev"
}

variable "image_id" {
    default = "ami-05ff0b3a7128cd6f8"
}
variable "instance_type" {
    default = "t2.micro"
}
variable "key_pair" {
    default = "terraform_key"
}
