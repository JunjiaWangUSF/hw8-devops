variable "aws_region" {
    type = string
    default = "us-east-1"
    description = "AWS default region"
}

variable "vpc_name"{
  type        = string
  default     = "my_vpc"
  description = "The name of the VPC" 
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR for the VPC"
}

variable "aws_azs" {
  description = "List of az in the specified region"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "aws_private_subnet_cidr" {
  description = "CIDR for the private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "aws_public_subnet_cidr" {
    description = "CIDR for the public subnets"
    type        = list(string)
    default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "resource_tags" {
    description = "Tags to be applied to all resources"
    type = map(string)
    default = {
        Environment = "dev"
        Project     = "packer-terraform"
        Owner       = "junjia"
    }
  
}


variable "bastion_prefix"{
  type        = string
  default     = "my-bastion-login"
  description = "Bastion prefix for the bastion resources"
}

variable "public_key" {
  type        = string
  description = "The public key to access your EC2 instances"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCP2b58o59W3tAH+RhHEDNe0OC8UhF7cEXVaRKKmQMahIm7ZV7055sLBd4svf12/2WYHylh5aMIWJEMiPeWFnNrIHWLhmhzfrVLI92Dzj424FthVRcIP2uyE5slnJ4q3C6gAYGf0uCRrjXC3zmj/qo6ucTVPH9oCSFAisaZIJ86RUL8Q1guBLP8SGBJP7JSeDnWzhpB8xnZP1OU04SjiXzmwAh2/KxN9g4HoJRCFalVk4kUmtrU5vg3lbT6vn9prtYjfFMPsgSubo2aJ0T7y7h1asGpvHPfJ+hFJAEQzg/xQKKEzwp/n/FR92wTzZ2g+qckMQ36dXoLz3zNUDMcPfd"
}

variable "your_ip" {
  description = "Your public IP address with /32 CIDR"
  type        = string
  default = "76.119.234.63/32"
}
