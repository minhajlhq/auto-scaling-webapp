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