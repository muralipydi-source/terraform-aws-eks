data "aws_ami" "joindevops" {
  owners           = ["973714476881"]
  most_recent      = true

  filter {
    name   = "AMI ID"
    values = ["ami-09c813fb71547fc4f"]
  }

  filter {
    name   = "AMI name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "Platform details"
    values = ["Red Hat Enterprise Linux"]
  }

  filter {
    name   = "Image type"
    values = ["machine"]
  }

  filter {
    name   = "Architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "Root device type"
    values = ["ebs"]
  }

  filter {
    name   = "Virtualization type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "bastion_sg_id" {
  name = "/${var.project}/${var.environment}/bastion_sg_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project}/${var.environment}/public_subnet_ids"
}

