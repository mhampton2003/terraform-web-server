provider "aws" {
  region = "us-west-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-web-server-state-backend"
    key    = "terraform.tfstate"
    region = "us-west-1"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

# resource "aws_subnet" "public_subnet" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.1.0/24"
#   # map_public_ip_on_launch = true

#   tags = {
#     Name = "Public Subnet"
#   }
# }

# resource "aws_internet_gateway" "gw" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "igw"
#   }
# }

# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.gw.id
#   }
#   tags = {
#     Name = "route-table"
#   }
# }

# resource "aws_route_table_association" "public" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public.id
# }

# resource "aws_security_group" "web_access" {
#   name_prefix = "web_access"
#   vpc_id      = aws_vpc.main.id
#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "HTTPS"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = -1
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "web_access"
#   }
# }

# resource "aws_instance" "web_server" {
#   ami                    = "ami-032db79bb5052ca0f"
#   instance_type          = "t3.micro"
#   subnet_id              = aws_subnet.public_subnet.id
#   vpc_security_group_ids = [aws_security_group.web_access.id]
#   #associate_public_ip_address = true

#   user_data = <<-EOF
#     #!/bin/bash
#     yum update -y
#     yum install httpd -y
#     service httpd start
#     chkconfig httpd on
#     cd /var/www/html
#     echo "<html><h1> HELLO AND WELCOME TO WEBIOSTE :D"</h1></html>
#     home.html
#   EOF

#   tags = {
#     Name = "terraform_web_server"
#   }

# }

# resource "aws_eip" "eip" {
#   instance = aws_instance.web_server.id
#   domain   = "vpc"

#   tags = {
#     Name = "elastic-ip"
#   }
# }

# resource "aws_eip_association" "epi_assoc" {
#   allocation_id = aws_eip.eip.id
#   instance_id   = aws_instance.web_server.id
# }