resource "aws_security_group" "app_sg" {
  name        = "app-instances-sg"
  description = "Allow internal traffic between app instances and SSH from bastion"
  vpc_id      = module.vpc.vpc_id

  # Allow SSH from bastion host
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
    description     = "SSH from Bastion host"
  }

  # Allow internal communication (optional)
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "Allow internal traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.resource_tags
}

resource "aws_instance" "app" {
  count         = 6
  ami           = "ami-07e6d0e00565a13bd"
  instance_type = "t2.micro"
  subnet_id     = module.vpc.private_subnets[count.index % length(module.vpc.private_subnets)]

  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = aws_key_pair.bastion-key.key_name

  associate_public_ip_address = false

  tags = merge(
    var.resource_tags,
    {
      Name = "app-instance-${count.index + 1}"
    }
  )
}
