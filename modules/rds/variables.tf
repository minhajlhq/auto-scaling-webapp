variable "name_prefix" {}
variable "vpc_id" {}
variable "private_subnet_ids" {
  type = list(string)
}
variable "ec2_sg_id" {}
variable "engine" {
  default = "mysql"
}
variable "db_family" {
  default = "mysql8.0"
}
variable "instance_class" {
  default = "db.t3.micro"
}
variable "allocated_storage" {
  default = 20
}
variable "multi_az" {
  default = false
}
variable "username" {}
variable "password" {}
variable "db_port" {
  default = 3306
}