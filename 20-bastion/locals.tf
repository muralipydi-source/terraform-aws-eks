locals{
    ami_id = "ami-0220d79f3f480ecf5" #data.aws_ami.joindevops.id
    bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
    public_subnet_id = split ("," , data.aws_ssm_parameter.public_subnet_ids.value)[0]

    common_tags = {
        Project = var.project
        Environment = var.environment
        Terraform = "true"
    }
}