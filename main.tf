terraform{
    required_providers{
        aws={
            source="hashicorp/aws"
            version="~>6.0"
        }
    }
}

provider"aws"{
    region= var.region
}

resource "aws_instance" "myec2" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [ aws_security_group.my_scg.id ]
    tags = {
      Name = "myec2"
    }
}

resource "aws_security_group" "my_scg" {
    name = "my_scg"
    description = "allowing SSH & HTTP"
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.allowed_ssh_cidr]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [var.allowed_http_cidr]
    }
}