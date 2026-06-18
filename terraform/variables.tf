variable "aws_region" {
    default = "eu-west-1"
}

variable "instance_type" {
    default = "t3.micro"
  
}

variable "ami_id" {
    description = "Ubuntu 22.04 ARM64 in eu-west-1"
    default = "ami-04df7d76c1b804451"
}

variable "key_name" {
    default = "devops-platform-key"
}