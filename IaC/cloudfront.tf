module "ecs_cloudfront" {
  source = "./modules/cloudfront"
	aliases                        = [var.domain_name]
  create_distribution            = true
  create_monitoring_subscription = false
  create_origin_access_identity  = false
  create_origin_access_control   = false

	origin = {
    ecs_alb = {
      domain_name = module.ecs_alb.lb_dns_name # Need to be updated
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }
  }

	default_cache_behavior = {
    target_origin_id       = "ecs_alb"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    query_string           = true
  }

	viewer_certificate = {
    acm_certificate_arn      = var.acm_certificate_arn # Need to be updated
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  depends_on = [
    module.ecs_alb
  ]
}