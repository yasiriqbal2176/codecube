variable "vpc_id" {
  description = "The ID of the existing VPC"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet where the bastion host will be launched"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the bastion host"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to associate with the instance"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the bastion host"
  type        = string
}

variable "bastion_sg_name" {
  description = "The name of the security group for the bastion host"
  type        = string
  default     = "bastion-host-sg"
}