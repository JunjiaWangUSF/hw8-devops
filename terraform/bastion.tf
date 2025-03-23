resource "aws_key_pair" "bastion-key" {
  key_name   = "bastion-key"
  public_key = var.public_key
}



resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH from my IP only"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ var.your_ip ] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.resource_tags
}


resource "aws_instance" "bastion" {
    ami = "ami-04aa00acb1165b32a"
    instance_type = "t2.micro"
    key_name = aws_key_pair.bastion-key.key_name
    security_groups = [aws_security_group.bastion_sg.id]
    subnet_id = module.vpc.public_subnets[0]
    tags = var.resource_tags
    associate_public_ip_address = true
}