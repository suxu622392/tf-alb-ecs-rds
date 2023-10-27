module "ecs_rds" {
  source                                = "./modules/rds/rds-instance"
  db_instance_engine                    = "mariadb"
  db_instance_name                      = "${var.environment}"
  db_instance_identifier                = "${var.environment}-database"
  db_instance_skip_snapshot             = false
  db_instance_final_snapshot_identifier = "${var.environment}-database-final-snapshot"
  db_instance_backup_retention_period   = 7
  db_instance_parameter_group           = module.ecs_rds_parameter_group.name
  db_instance_security_groups           = [module.ecs_rds_security_group.security_group_id]
  db_instance_subnet_name               = module.ecs_rds_subnet_group.subnet_group_name
  db_instance_engine_version            = "10.6.14"
  db_instance_instance_class            = var.rds_instance_class
  db_instance_username                  = "admin"
  db_instance_password                  = random_password.db_pass.result
  db_instance_storage_type              = "gp2"
  db_instance_storage                   = 20
  db_instance_max_storage               = 50
  db_instance_iops                      = null
  db_instance_multi_az                  = true
  db_instance_encryption                = true
  environment                           = var.environment
  owner                                 = var.owner
  tags = var.tags
}

module "ecs_rds_parameter_group" {
  source      = "./modules/rds/rds-parameter-group"
  environment = var.environment
  family      = "mariadb10.6"
  description = "Parameter group for the ${var.environment}"
  name        = "${var.environment}-mariadb"
}

module "ecs_rds_subnet_group" {
  source         = "./modules/rds/rds-subnet-group"
  db_subnet_name = "${var.environment}-subnet-group"
  db_subnets     = [module.ecs_first_private_subnet.subnet_id, module.ecs_second_private_subnet.subnet_id, module.ecs_third_private_subnet.subnet_id]
  environment    = var.environment
}