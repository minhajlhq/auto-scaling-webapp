variable "name_prefix" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "alb_sg_id" {}

variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}

variable "desired_capacity" {
  default = 2
}
variable "max_size" {
  default = 3
}
variable "min_size" {
  default = 1
}

variable "target_group_arns" {
  type = list(string)
}