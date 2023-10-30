module "ecs_efs" {
 	source = "./modules/efs"
	
	# File system
  name           = "${var.environment}-efs"
  encrypted      = true
  # kms_key_arn    = "arn:aws:kms:eu-west-1:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"

  performance_mode                = "maxIO"
  throughput_mode                 = "provisioned"
  provisioned_throughput_in_mibps = 256

  lifecycle_policy = {
    transition_to_ia = "AFTER_30_DAYS"
  }


  # Mount targets / security group
	mount_targets = {
    "ap-southeast-1a" = {
      subnet_id = module.ecs_first_private_subnet.subnet_id
    }
    "ap-southeast-1b" = {
      subnet_id = module.ecs_second_private_subnet.subnet_id
    }
    "ap-southeast-1c" = {
      subnet_id = module.ecs_third_private_subnet.subnet_id
    }
  }
  security_group_description = "Example EFS security group"
  security_group_vpc_id      = module.ecs_vpc.vpc_id
  security_group_rules = {
    vpc = {
      # relying on the defaults provdied for EFS/NFS (2049/TCP + ingress)
      description = "NFS ingress from VPC private subnets"
      cidr_blocks = [module.ecs_first_private_subnet.subnet_id, module.ecs_second_private_subnet.subnet_id, module.ecs_third_private_subnet.subnet_id]
    }
  }

  # Backup policy
  enable_backup_policy = true

  tags = var.tags
}