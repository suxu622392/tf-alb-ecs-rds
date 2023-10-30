variable "environment" {
}

# variable "region" {
# }

variable "owner" {
}

# variable "aws_account_id" {
# }

variable "tags" {
  type = map(string)
}

variable "domain_name" {
}

# variable "domain_name_private" {
# }

variable "vpc_cidr_block" {
}

variable "private_first_subnet_cird_block" {
}

variable "private_second_subnet_cird_block" {
}

variable "private_third_subnet_cird_block" {
}

variable "public_first_subnet_cird_block" {
}

variable "public_second_subnet_cird_block" {
}

variable "public_third_subnet_cird_block" {
}

variable "acm_certificate_arn" {
}

variable "rds_instance_class" {
}

# variable "eks_node_group_desired_size_euw1a" {}
# variable "eks_node_group_min_size_euw1a" {}
# variable "eks_node_group_max_size_euw1a" {}

# variable "eks_node_group_desired_size_euw1b" {}
# variable "eks_node_group_min_size_euw1b" {}
# variable "eks_node_group_max_size_euw1b" {}

# variable "eks_node_group_desired_size_euw1c" {}
# variable "eks_node_group_min_size_euw1c" {}
# variable "eks_node_group_max_size_euw1c" {}

# variable "eks_node_group_instance_types" {
#   type = list(string)
# }

# variable "eks_node_group_ami_release_version" {
# }

# variable "eks_cluster_version" {
# }
# variable "elasticsearch_version" {
# }
# variable "elasticsearch_kms_key_id" {
# }
# variable "elasticsearch_ebs_volume_size" {
# }
# variable "elasticsearch_instance_type" {
# }
# variable "cloudfront_enabled" {}
# //variable "route53_zone_id" {}
# variable "certificate_domain" {}
# variable "cloudfront_distribution_aliases" {
#   type = list(string)
# }
# variable "dns_record_cloudfront" {}

# variable "create_ses_templates" {}
# variable "management_eks_node_group_desired_size" {}
# variable "management_eks_node_group_min_size" {}
# variable "management_eks_node_group_max_size" {}
# variable "management_eks_node_group_ami_release_version" {}
# variable "management_eks_node_group_disk_size" {}
# variable "management_eks_node_group_instance_types" {
#   type = list(string)
# }

# variable "jenkins_eks_node_group_desired_size" {
#   default = null
# }
# variable "jenkins_eks_node_group_min_size" {
#   default = null
# }
# variable "jenkins_eks_node_group_max_size" {
#   default = null
# }
# variable "jenkins_eks_node_group_ami_release_version" {
#   default = null
# }
# variable "jenkins_eks_node_group_disk_size" {
#   default = null
# }
# variable "jenkins_eks_node_group_instance_types" {
#   default = null
#   type = list(string)
# }

# variable "spot_eks_node_group_desired_size_euw1a" {}
# variable "spot_eks_node_group_min_size_euw1a" {}
# variable "spot_eks_node_group_max_size_euw1a" {}

# variable "spot_eks_node_group_desired_size_euw1b" {}
# variable "spot_eks_node_group_min_size_euw1b" {}
# variable "spot_eks_node_group_max_size_euw1b" {}

# variable "spot_eks_node_group_desired_size_euw1c" {}
# variable "spot_eks_node_group_min_size_euw1c" {}
# variable "spot_eks_node_group_max_size_euw1c" {}

# variable "spot_eks_node_group_ami_release_version" {}
# variable "spot_eks_node_group_instance_types" {
#   type = list(string)
# }

# variable "transit_gateway_id" {}

# variable "internal_dns_ip_1" {}

# variable "internal_dns_ip_2" {}

# variable "domain_dns_resolve_name_internal" {}


# variable "it_vpc_cidr_block" {}

# variable "it_vpc_cidr_block1" {}

# variable "on_prem_cambridge_cidr_block" {}

# variable "attach_policy_to_apk_bucket" {}

# variable "bastion_sg_id" {
#   default = ""
# }

# variable "eks_cluster_endpoint_private_access" {
#   default = true
# }

# variable "eks_cluster_endpoint_public_access" {}

# variable "eks_addon_vpc_cni_version" {
#   default = null
# }

# variable "eks_addon_kube_proxy_version" {
#   default = null
# }

# variable "eks_addon_coredns_version" {
#   default = null
# }

# variable "eks_addon_ebs_csi_driver_version" {
#   default = null
# }

# variable "eks_node_group_ami_type" {
#   default = "AL2_x86_64"
# }

# variable "db_snapshot_identifier" {
#   default = null
# }