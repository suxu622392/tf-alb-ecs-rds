###SECURITY GROUP OF ALB ECS###

module "alb_ecs_security_group" {
  source                                = "./modules/security-group-all-in-one"
  environment                           = var.environment
  owner                                 = var.owner
  security_group_name                   = "${var.environment}-alb-ecs-sg"
  security_group_description            = "SG for ALB of ECS"
  vpc_id                                = module.ecs_vpc.vpc_id
  security_group_revoke_rules_on_delete = false
  security_group_egress_rules = [
    {
      cidr_blocks = [
        "0.0.0.0/0"
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  security_group_ingress_rules = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "alb-ecs-http"
      from_port        = 80
      to_port          = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "TCP"
      security_groups  = []
      self             = false

    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "alb-ecs-https"
      from_port        = 443
      to_port          = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "TCP"
      security_groups  = []
      self             = false

    }
  ]

  tags = var.tags
}

###SECURITY GROUP OF DB###
module "ecs_rds_security_group" {
  source                                = "./modules/security-group-all-in-one"
  environment                           = var.environment
  owner                                 = var.owner
  security_group_name                   = "${var.environment}-mariadb-sg"
  security_group_description            = "allow access for ECS cluster to RDS"
  vpc_id                                = module.ecs_vpc.vpc_id
  security_group_revoke_rules_on_delete = false
  security_group_egress_rules = [
    {
      cidr_blocks = [
        "0.0.0.0/0"
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  security_group_ingress_rules = [
    {
      cidr_blocks      = [var.vpc_cidr_block]
      description      = ""
      from_port        = 5506
      to_port          = 5506
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "TCP"
      security_groups  = []
      self             = true
    }
  ]
  tags = var.tags
}