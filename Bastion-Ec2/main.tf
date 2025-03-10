provider "aws" {
  #region = "af-south-1" # Change to your desired region
  region                      = "af-south-1"
}

resource "aws_security_group" "bastion_sg" {
  name        = var.bastion_sg_name
  description = "Security group for bastion host"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["203.41.21.43/32"] #Used your IP to Allow SSH access from IP restricted  (restrict this in production)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }

  tags = {
    Name = var.bastion_sg_name
  }
}

resource "aws_instance" "bastion_host" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  tags = {
    Name = "Bastion-Host"
  }
}

output "bastion_host_public_ip" {
  description = "The public IP address of the bastion host"
  value       = aws_instance.bastion_host.public_ip
}