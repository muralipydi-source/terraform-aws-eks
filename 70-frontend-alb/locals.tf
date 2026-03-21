locals {
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    public_subnet_ids = split ("," , data.aws_ssm_parameter.public_subnet_ids.value) # split() converts a string into a list.
    ingress_alb_sg_id = data.aws_ssm_parameter.ingress_alb_sg_id.value
    acm_certificate_arn = data.aws_ssm_parameter.acm_certificate_arn.value
    common_tags = {
        Project = var.project
        Environment = var.environment   
        Terraform = "true"
    }
}

# Real Example in Roboshop Terraform

# SSM Parameter:

# /roboshop/dev/public_subnet_ids

# Value:

# subnet-aaa,subnet-bbb,subnet-ccc

# Terraform:

# data "aws_ssm_parameter" "public_subnet_ids" {
#   name = "/roboshop/dev/public_subnet_ids"
# }

# locals {
#   public_subnet_ids = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
# }

# Then used in ALB:

# subnets = local.public_subnet_ids

# ✅ Simple summary

# SSM value → "subnet1,subnet2,subnet3"
# split()   → ["subnet1","subnet2","subnet3"]
