variable "vpc_cidr" {
type = string
description = " CIDR BLOCK FOR VPC"
}

variable "name_prefix" {
type = string
}

variable "public_subnet_cidrs" {
    type = list(string)
    description = "CIDR BLOCK FOR PUBLIC SUBNETS "
}

variable "private_subnet_cidrs" {
    type = list(string)
    description = "CIDR BLOCK FOR PRIVATE SUBNETS"

}

variable "azs" {
    type = list(string)
    description = "Availability Zones"
    
}

variable "ami_id" {
  description = "Amazon Linux 2 or Ubuntu AMI ID"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "SSH Key pair name"
}

variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "db_username" {}
variable "db_password" {}