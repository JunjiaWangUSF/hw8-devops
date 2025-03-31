resource "aws_instance" "ansible-controller" {
    ami = "ami-01445c53e30d3ffce"
    instance_type = "t2.micro"
    key_name = aws_key_pair.bastion-key.key_name
    security_groups = [aws_security_group.bastion_sg.id]
    subnet_id = module.vpc.public_subnets[0]
    associate_public_ip_address = true

    tags = merge(
    var.resource_tags,
    {
      Name = "ansible-controller"
    }
  )
}