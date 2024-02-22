provider "aws" {
    region = "ap-northeast-3"
}

terraform {
    backend "s3" {
        region = "ap-northeast-3"
        bucket = "first_bucket"
        key = "./terraform.tfstate"
    }
}

data "aws_security_group" "existing_sg" {
    name = "default"
    vpc_id = "vpc-04a99618ed9d54ae8"

}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  to_port           = 22
  protocol          = "TCP"
  from_port         = 22
  cidr_blocks        =   ["0.0.0.0/0"]
  security_group_id = data.aws_security_group.existing_sg.id
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  to_port           = 80
  protocol          = "TCP"
  from_port         = 80
  cidr_blocks        =   ["0.0.0.0/0"]
  security_group_id = data.aws_security_group.existing_sg.id
}

resource "aws_instance" "my_instance" {
    ami = "ami-0440d3b780d96b29d"
    instance_type = "t3.micro"
    key_name = "osaka-key"
    vpc_security_group_ids = [data.aws_security_group.existing_sg.id]

    connection {
        type     = "ssh"
        user     = "root"
        private_key = file("./private.pem")
        host     = self.public_ip
    }

    provisioner "remote-exec" {
    inline = [
        "yum install httpd -y",
        "systemctl start httpd",
        "systemctl enable httpd"
        ]
    }

    provisioner "local-exec" {
        command = "echo '<h1> Hello World Welcome to India' > index.html"
        # command = "echo ${self.public_ip} >> ips.txt"
    }

    provisioner "file" {
        source = "index.html"
        destination = "/var/www/html/index.html"
    }
}
