variable "aws_region" {
    default = "eu-west-1"
}

variable "instance_type" {
    default = "t3.micro"
  
}

variable "ami_id" {
    description = "Ubuntu 22.04 ARM64 in eu-west-1"
    default = "ami-0d64d60b2f8c79c58"
}

variable "key_name" {
    default = "devops-platform-key"
}