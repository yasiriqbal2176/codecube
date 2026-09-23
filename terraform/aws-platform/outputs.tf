output "vpc_id" {
  value = aws_vpc.this.id
}

output "eks_cluster_name" {
  value = aws_eks_cluster.this.name
}

output "eks_cluster_endpoint" {
  value     = aws_eks_cluster.this.endpoint
  sensitive = true
}

output "rds_endpoint" {
  value     = aws_db_instance.postgres.address
  sensitive = true
}
