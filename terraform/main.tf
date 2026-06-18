provider "aws" {
    region = var.aws_region
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    tags = { name = "devops-platform-vpc" }
}

resource "aws_subnet" "main_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    tags = { name = "devops-platform-subnet" }
}

resource "aws_internet_gateway" "main_gateway" {
    vpc_id = aws_vpc.main.id
    tags = { name = "devops-platform-gw" }
}

resource "aws_route_table" "main" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main_gateway.id
    }

    tags = { name = "devops-platform-rt" }
}

resource "aws_route_table_association" "main" {
    subnet_id = aws_subnet.main_subnet.id
    route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "main" {
    name = "devops-platform-sg"
    vpc_id = aws_vpc.main.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["81.5.52.229/32"]
    }

    ingress {
        from_port = 6443
        to_port = 6443
        protocol = "tcp"
        cidr_blocks = ["81.5.52.229/32"]
    }

    ingress {
        from_port = 10250
        to_port = 10250
        protocol = "tcp"
        cidr_blocks = ["81.5.52.229/32"]
    }
    
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["10.0.1.0/24"]
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "control_plane" {
    ami = var.ami_id
    instance_type = var.control_plane_instance_type
    subnet_id = aws_subnet.main_subnet.id
    vpc_security_group_ids = [aws_security_group.main.id]
    associate_public_ip_address = true
    key_name = "devops-platform-key"

    tags = { Name = "control-plane" }
}

resource "aws_instance" "test_worker" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.main_subnet.id
    vpc_security_group_ids = [aws_security_group.main.id]
    associate_public_ip_address = true
    key_name = "devops-platform-key"

    tags = { Name = "test_worker" }
}

resource "aws_instance" "prod_worker" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.main_subnet.id
    vpc_security_group_ids = [aws_security_group.main.id]
    associate_public_ip_address = true
    key_name = "devops-platform-key"

    tags = { Name = "prod_worker" }
}

