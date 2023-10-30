tags = {
    "Team"        = "DevOps"
    "Environment" = "cissp-dev"
    "Terraform"   = "true"
    "owner"       = "itaas"
}
environment                                   = "cissp-dev"
owner                                         = "itaas-DevOps"
vpc_cidr_block                                = "10.110.0.0/16"
private_first_subnet_cird_block               = "10.110.0.0/19"
private_second_subnet_cird_block              = "10.110.32.0/19"
private_third_subnet_cird_block               = "10.110.64.0/19"
public_first_subnet_cird_block                = "10.110.96.0/19"
public_second_subnet_cird_block               = "10.110.128.0/19"
public_third_subnet_cird_block                = "10.110.160.0/19"


domain_name = "dev.cissp.vn"
acm_certificate_arn = ""

rds_instance_class = "db.t4g.small"