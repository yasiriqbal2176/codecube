variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-1"
}

variable "project_name" {
  type        = string
  description = "Project name used in resource names"
  default     = "devops-sre-lab"
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR for the VPC"
  default     = "10.20.0.0/16"
}

variable "subnets" {
  description = "Dynamic subnet map for public/EC2, EKS and database tiers"
  type = map(object({
    cidr   = string
    az     = string
    public = bool
    tier   = string
  }))

  default = {
    public-a = { cidr = "10.20.0.0/24",  az = "eu-west-1a", public = true,  tier = "public" }
    public-b = { cidr = "10.20.1.0/24",  az = "eu-west-1b", public = true,  tier = "public" }
    eks-a    = { cidr = "10.20.10.0/24", az = "eu-west-1a", public = false, tier = "eks" }
    eks-b    = { cidr = "10.20.11.0/24", az = "eu-west-1b", public = false, tier = "eks" }
    db-a     = { cidr = "10.20.20.0/24", az = "eu-west-1a", public = false, tier = "database" }
    db-b     = { cidr = "10.20.21.0/24", az = "eu-west-1b", public = false, tier = "database" }
  }
}

variable "eks_version" {
  type        = string
  description = "Kubernetes version. Set this to a version supported in your target AWS region."
  default     = "1.33"
}

variable "node_instance_types" {
  type        = list(string)
  description = "EKS managed node group instance types"
  default     = ["t3.medium"]
}

variable "db_username" {
  type        = string
  description = "RDS master username"
  default     = "appadmin"
}

variable "db_password" {
  type        = string
  description = "RDS master password. Supply through TF_VAR_db_password or a secret manager."
  sensitive   = true
}
