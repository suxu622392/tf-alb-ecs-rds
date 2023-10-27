module "ecs_alb" {
  source                = "./modules/alb"
  name                  = "${var.environment}-alb"
  load_balancer_type    = "application"
  vpc_id                = module.ecs_vpc.vpc_id
  subnets               = [module.ecs_first_public_subnet.subnet_id, module.ecs_second_public_subnet.subnet_id, module.ecs_third_public_subnet.subnet_id]
  create_security_group = false
  security_groups       = [module.alb_ecs_security_group.security_group_id]
  target_groups = [
    {
      name             = "${var.environment}-target-group"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
      health_check = {
        matcher             = "200"
        path                = "/health"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 5
        unhealthy_threshold = 2
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = var.acm_certificate_arn
      target_group_index = 0
    }
  ]

  depends_on = [module.alb_ecs_security_group]

  tags = var.tags
}