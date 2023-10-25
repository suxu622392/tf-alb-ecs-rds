module "ecs_vpc" {
  source                   = "./modules/network/vpc"
  environment              = var.environment
  vpc_cidr_block           = var.vpc_cidr_block
  vpc_enable_dns_hostnames = true
  vpc_enable_dns_support   = true
  vpc_instance_tenancy     = "default"
  vpc_name                 = "${var.environment}-VPC"
#   tags = {
#     "kubernetes.io/cluster/${var.ecs_cluster_name}" = "shared"
#   }
}

module "ecs_internet_gateway" {
  source                = "./modules/network/vpc-internet-gateway"
  environment           = var.environment
  internet_gateway_name = "${var.environment}-IGW"
  vpc_id                = module.ecs_vpc.vpc_id
}

module "ecs_elastic_ip_nat_gateway" {
  source          = "./modules/network/vpc-elastic-ip"
  environment     = var.environment
  elastic_ip_name = "${var.environment}-NatGwEiP"
}

module "ecs_nat_gateway" {
  source           = "./modules/network/vpc-nat-gateway"
  allocation_id    = module.ecs_elastic_ip_nat_gateway.elastic_ip_id
  environment      = var.environment
  nat_gateway_name = "${var.environment}-NatGW"
  subnet_id        = module.ecs_second_public_subnet.subnet_id
}

module "ecs_first_private_subnet" {
  source                   = "./modules/network/vpc-subnet"
  environment              = var.environment
  subnet_availability_zone = "eu-west-1a"
  subnet_cird_block        = var.private_first_subnet_cird_block
  subnet_name              = "${var.environment}-first-private"
  vpc_id                   = module.ecs_vpc.vpc_id
#   tags = {
#     "kubernetes.io/cluster/${var.ecs_cluster_name}" = "shared"
#     "kubernetes.io/role/internal-elb"               = 1
#   }
}

module "ecs_second_private_subnet" {
  source                   = "./modules/network/vpc-subnet"
  environment              = var.environment
  subnet_availability_zone = "eu-west-1b"
  subnet_cird_block        = var.private_second_subnet_cird_block
  subnet_name              = "${var.environment}-second-private"
  vpc_id                   = module.ecs_vpc.vpc_id
#   tags = {
#     "kubernetes.io/cluster/${var.ecs_cluster_name}" = "shared"
#     "kubernetes.io/role/internal-elb"               = 1
#   }
}

module "ecs_third_private_subnet" {
  source                   = "./modules/network/vpc-subnet"
  environment              = var.environment
  subnet_availability_zone = "eu-west-1c"
  subnet_cird_block        = var.private_third_subnet_cird_block
  subnet_name              = "${var.environment}-third-private"
  vpc_id                   = module.ecs_vpc.vpc_id
#   tags = {
#     "kubernetes.io/cluster/${var.ecs_cluster_name}" = "shared"
#     "kubernetes.io/role/internal-elb"               = 1
#   }
}

module "ecs_first_public_subnet" {
  source                   = "./modules/network/vpc-subnet"
  environment              = var.environment
  subnet_availability_zone = "eu-west-1a"
  subnet_cird_block        = var.public_first_subnet_cird_block
  subnet_name              = "${var.environment}-first-public"
  vpc_id                   = module.ecs_vpc.vpc_id
#   tags = {
#     "kubernetes.io/cluster/${var.ecs_cluster_name}" = "shared"
#     "kubernetes.io/role/elb"                        = 1
#   }
}

module "ecs_second_public_subnet" {
  source                   = "./modules/network/vpc-subnet"
  environment              = var.environment
  subnet_availability_zone = "eu-west-1b"
  subnet_cird_block        = var.public_second_subnet_cird_block
  subnet_name              = "${var.environment}-second-public"
  vpc_id                   = module.ecs_vpc.vpc_id
#   tags = {
#     "kubernetes.io/cluster/${var.ecs_cluster_name}" = "shared"
#     "kubernetes.io/role/elb"                        = 1
#   }
}

module "ecs_third_public_subnet" {
  source                   = "./modules/network/vpc-subnet"
  environment              = var.environment
  subnet_availability_zone = "eu-west-1c"
  subnet_cird_block        = var.public_third_subnet_cird_block
  subnet_name              = "${var.environment}-third-public"
  vpc_id                   = module.ecs_vpc.vpc_id
#   tags = {
#     "kubernetes.io/cluster/${var.ecs_cluster_name}" = "shared"
#     "kubernetes.io/role/elb"                        = 1
#   }
}

module "ecs_public_route_table" {
  source           = "./modules/network/vpc-route-table"
  environment      = var.environment
  route_table_name = "${var.environment}-Public-RT"
  vpc_id           = module.ecs_vpc.vpc_id
}

module "ecs_main_route_table" {
  source         = "./modules/network/vpc-main-route-table-association"
  route_table_id = module.ecs_public_route_table.route_table_id
  vpc_id         = module.ecs_vpc.vpc_id
}

# module "ecs_transit_gateway_attachment" {
#   source = "./modules/network/vpc-transit-gateway-attachment"
#   subnet_ids = [
#     module.ecs_first_private_subnet.subnet_id,
#     module.ecs_second_private_subnet.subnet_id,
#     module.ecs_third_private_subnet.subnet_id
#   ]
#   transit_gateway_id = var.transit_gateway_id
#   vpc_id             = module.ecs_vpc.vpc_id
#   environment        = var.environment
#   name               = "${var.environment}-TGA"
# }

module "ecs_public_route_table_route_internet_gateway" {
  source                 = "./modules/network/vpc-route-internet-gateway"
  gateway_id             = module.ecs_internet_gateway.internet_gateway_id
  route_table_id         = module.ecs_public_route_table.route_table_id
  destination_cidr_block = "0.0.0.0/0"
}

# module "ecs_public_route_table_route_transit_gateway_dc1_1" {
#   source                 = "./modules/network/vpc-route-transit-gateway"
#   destination_cidr_block = var.it_vpc_cidr_block1
#   route_table_id         = module.ecs_public_route_table.route_table_id
#   transit_gateway_id     = var.transit_gateway_id
# }

# module "ecs_public_route_table_route_transit_gateway_cambridge_1" {
#   source                 = "./modules/network/vpc-route-transit-gateway"
#   destination_cidr_block = var.on_prem_cambridge_cidr_block
#   route_table_id         = module.ecs_public_route_table.route_table_id
#   transit_gateway_id     = var.transit_gateway_id
# }

module "ecs_public_route_table_subnet_association_1" {
  source         = "./modules/network/vpc-route-table-association"
  route_table_id = module.ecs_public_route_table.route_table_id
  subnet_id      = module.ecs_first_public_subnet.subnet_id
}

module "ecs_public_route_table_subnet_association_2" {
  source         = "./modules/network/vpc-route-table-association"
  route_table_id = module.ecs_public_route_table.route_table_id
  subnet_id      = module.ecs_second_public_subnet.subnet_id
}

module "ecs_public_route_table_subnet_association_3" {
  source         = "./modules/network/vpc-route-table-association"
  route_table_id = module.ecs_public_route_table.route_table_id
  subnet_id      = module.ecs_third_public_subnet.subnet_id
}

module "ecs_private_route_table" {
  source           = "./modules/network/vpc-route-table"
  environment      = var.environment
  route_table_name = "${var.environment}-Private-RT"
  vpc_id           = module.ecs_vpc.vpc_id
}

module "ecs_private_route_table_route_nat_gateway" {
  source                 = "./modules/network/vpc-route-nat-gateway"
  nat_gateway_id         = module.ecs_nat_gateway.nat_gateway_id
  route_table_id         = module.ecs_private_route_table.route_table_id
  destination_cidr_block = "0.0.0.0/0"
}

# module "ecs_private_route_table_route_transit_gateway_dc1_1" {
#   source                 = "./modules/network/vpc-route-transit-gateway"
#   destination_cidr_block = var.it_vpc_cidr_block1
#   route_table_id         = module.ecs_private_route_table.route_table_id
#   transit_gateway_id     = var.transit_gateway_id
# }

# module "ecs_private_route_table_route_transit_gateway_cambridge_1" {
#   source                 = "./modules/network/vpc-route-transit-gateway"
#   destination_cidr_block = var.on_prem_cambridge_cidr_block
#   route_table_id         = module.ecs_private_route_table.route_table_id
#   transit_gateway_id     = var.transit_gateway_id
# }

# module "ecs_private_route_table_route_transit_gateway_it_vpc" {
#   source                 = "./modules/network/vpc-route-transit-gateway"
#   destination_cidr_block = var.it_vpc_cidr_block
#   route_table_id         = module.ecs_private_route_table.route_table_id
#   transit_gateway_id     = var.transit_gateway_id
# }

module "ecs_private_route_table_subnet_association_1" {
  source         = "./modules/network/vpc-route-table-association"
  route_table_id = module.ecs_private_route_table.route_table_id
  subnet_id      = module.ecs_first_private_subnet.subnet_id
}

module "ecs_private_route_table_subnet_association_2" {
  source         = "./modules/network/vpc-route-table-association"
  route_table_id = module.ecs_private_route_table.route_table_id
  subnet_id      = module.ecs_second_private_subnet.subnet_id
}

module "ecs_private_route_table_subnet_association_3" {
  source         = "./modules/network/vpc-route-table-association"
  route_table_id = module.ecs_private_route_table.route_table_id
  subnet_id      = module.ecs_third_private_subnet.subnet_id
}

# resource "aws_vpc_endpoint_route_table_association" "private_dynamo_db" {
#   vpc_endpoint_id = module.vpc_endpoints.vpc_endpoint_id_dynamo_db
#   route_table_id  = module.ecs_private_route_table.route_table_id
# }

# module "vpc_endpoints" {
#   source = "./modules/network/vpc-endpoint"
#   vpc_id                                 = module.ecs_vpc.vpc_id
#   s3_endpoint_enable                     = true
#   dynamo_db_endpoint_enable              = true
#   ec2_endpoint_enable                    = true
#   autoscaling_endpoint_enable            = true
#   ecr_api_endpoint_enable                = true
#   ecr_dkr_endpoint_enable                = true
#   elasticloadbalancing_endpoint_enable   = true
#   logs_endpoint_enable                   = true
#   sts_endpoint_enable                    = true
#   subnet_ids                             = [
#     module.ecs_first_private_subnet.subnet_id,
#     module.ecs_second_private_subnet.subnet_id,
#     module.ecs_third_private_subnet.subnet_id
#   ]
#   route_tables = [
#     module.ecs_private_route_table.route_table_id
#   ]
#   security_group_id = module.main_ecs_cluster.ecs_cluster_sg_id
#   environment                            = var.environment
#   owner                                  = var.owner
#   region                                 = var.region
# }