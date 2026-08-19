module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block             = var.vpc_cidr_block
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  availability_zones         = var.availability_zones
  default_cidr_block         = var.default_cidr_block
}

module "acm" {
  source = "./modules/acm"

  domain_name     = "tools.osmanhus.co.uk"
  route53_zone_id = "Z07309333UA1A4Q6ZLQ9L"
}

module "alb" {
  source = "./modules/alb"

  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  default_cidr_block  = var.default_cidr_block
  app_port            = 8080
  acm_certificate_arn = module.acm.certificate_arn
}

module "ecs" {
  source = "./modules/ecs"

  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  alb_security_group_id = module.alb.alb_security_group_id
  target_group_arn      = module.alb.target_group_arn
  ecr_repository_url    = "606349121896.dkr.ecr.eu-west-2.amazonaws.com/it-tools-fargate"

  app_port    = 8080
  task_cpu    = 256
  task_memory = 512
  image_tag   = var.image_tag
}

resource "aws_route53_record" "app" {
  zone_id = "Z07309333UA1A4Q6ZLQ9L"
  name    = "tools.osmanhus.co.uk"
  type    = "A"

  alias {
    name                   = module.alb.alb_dns_name
    zone_id                = module.alb.alb_zone_id
    evaluate_target_health = true
  }
}