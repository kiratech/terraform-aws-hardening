## Global account hardening
module "aws-global" {
  aws_region = "us-east-1"
  source     = "modules/hardening-global"
}

## Region-specific hardening
## List taken from: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html

module "aws-us-east-2" {
  aws_region            = "us-east-2"
  aws_config_bucket     = "${module.aws-global.aws_config_bucket}"
  aws_config_role_arn   = "${module.aws-global.aws_config_role_arn}"
  aws_flowlogs_role_arn = "${module.aws-global.aws_flowlogs_role_arn}"
  source                = "modules/hardening-region"
}

module "aws-us-east-1" {
  aws_region            = "us-east-1"
  aws_config_bucket     = "${module.aws-global.aws_config_bucket}"
  aws_config_role_arn   = "${module.aws-global.aws_config_role_arn}"
  aws_flowlogs_role_arn = "${module.aws-global.aws_flowlogs_role_arn}"
  source                = "modules/hardening-region"
}

module "aws-us-west-1" {
  aws_region            = "us-west-1"
  aws_config_bucket     = "${module.aws-global.aws_config_bucket}"
  aws_config_role_arn   = "${module.aws-global.aws_config_role_arn}"
  aws_flowlogs_role_arn = "${module.aws-global.aws_flowlogs_role_arn}"
  source                = "modules/hardening-region"
}

module "aws-us-west-2" {
  aws_region            = "us-west-2"
  aws_config_bucket     = "${module.aws-global.aws_config_bucket}"
  aws_config_role_arn   = "${module.aws-global.aws_config_role_arn}"
  aws_flowlogs_role_arn = "${module.aws-global.aws_flowlogs_role_arn}"
  source                = "modules/hardening-region"
}

module "aws-ap-south-1" {
  aws_region            = "ap-south-1"
  aws_config_bucket     = "${module.aws-global.aws_config_bucket}"
  aws_config_role_arn   = "${module.aws-global.aws_config_role_arn}"
  aws_flowlogs_role_arn = "${module.aws-global.aws_flowlogs_role_arn}"
  source                = "modules/hardening-region"
}

module "aws-ap-northeast-2" {
  aws_region            = "ap-northeast-2"
  aws_config_bucket     = "${module.aws-global.aws_config_bucket}"
  aws_config_role_arn   = "${module.aws-global.aws_config_role_arn}"
  aws_flowlogs_role_arn = "${module.aws-global.aws_flowlogs_role_arn}"
  source                = "modules/hardening-region"
}

module "aws-ap-southeast-1" {
  aws_region            = "ap-southeast-1"
  aws_config_bucket     = "${module.aws-global.aws_config_bucket}"
  aws_config_role_arn   = "${module.aws-global.aws_config_role_arn}"
  aws_flowlogs_role_arn = "${module.aws-global.aws_flowlogs_role_arn}"
  source                = "modules/hardening-region"
}

module "aws-ap-southeast-2" {
  aws_region            = "ap-southeast-2"
  aws_config_bucket     = "${module.aws-global.aws_config_bucket}"
  aws_config_role_arn   = "${module.aws-global.aws_config_role_arn}"
  aws_flowlogs_role_arn = "${module.aws-global.aws_flowlogs_role_arn}"
  source                = "modules/hardening-region"
}

module "aws-ap-northeast-1" {
  aws_region            = "ap-northeast-1"
  aws_config_bucket     = "${module.aws-global.aws_config_bucket}"
  aws_config_role_arn   = "${module.aws-global.aws_config_role_arn}"
  aws_flowlogs_role_arn = "${module.aws-global.aws_flowlogs_role_arn}"
  source                = "modules/hardening-region"
}

module "aws-ca-central-1" {
  aws_region            = "ca-central-1"
  aws_config_bucket     = "${module.aws-global.aws_config_bucket}"
  aws_config_role_arn   = "${module.aws-global.aws_config_role_arn}"
  aws_flowlogs_role_arn = "${module.aws-global.aws_flowlogs_role_arn}"
  source                = "modules/hardening-region"
}

module "aws-eu-central-1" {
  aws_region            = "eu-central-1"
  aws_config_bucket     = "${module.aws-global.aws_config_bucket}"
  aws_config_role_arn   = "${module.aws-global.aws_config_role_arn}"
  aws_flowlogs_role_arn = "${module.aws-global.aws_flowlogs_role_arn}"
  source                = "modules/hardening-region"
}

module "aws-eu-west-1" {
  aws_region            = "eu-west-1"
  aws_config_bucket     = "${module.aws-global.aws_config_bucket}"
  aws_config_role_arn   = "${module.aws-global.aws_config_role_arn}"
  aws_flowlogs_role_arn = "${module.aws-global.aws_flowlogs_role_arn}"
  source                = "modules/hardening-region"
}

module "aws-eu-west-2" {
  aws_region            = "eu-west-2"
  aws_config_bucket     = "${module.aws-global.aws_config_bucket}"
  aws_config_role_arn   = "${module.aws-global.aws_config_role_arn}"
  aws_flowlogs_role_arn = "${module.aws-global.aws_flowlogs_role_arn}"
  source                = "modules/hardening-region"
}

module "aws-eu-west-3" {
  aws_region            = "eu-west-3"
  aws_config_bucket     = "${module.aws-global.aws_config_bucket}"
  aws_config_role_arn   = "${module.aws-global.aws_config_role_arn}"
  aws_flowlogs_role_arn = "${module.aws-global.aws_flowlogs_role_arn}"
  source                = "modules/hardening-region"
}

module "aws-eu-north-1" {
  aws_region            = "eu-north-1"
  aws_config_bucket     = "${module.aws-global.aws_config_bucket}"
  aws_config_role_arn   = "${module.aws-global.aws_config_role_arn}"
  aws_flowlogs_role_arn = "${module.aws-global.aws_flowlogs_role_arn}"
  source                = "modules/hardening-region"
}

module "aws-sa-east-1" {
  aws_region            = "sa-east-1"
  aws_config_bucket     = "${module.aws-global.aws_config_bucket}"
  aws_config_role_arn   = "${module.aws-global.aws_config_role_arn}"
  aws_flowlogs_role_arn = "${module.aws-global.aws_flowlogs_role_arn}"
  source                = "modules/hardening-region"
}

#module "aws-ap-northeast-3" {
#    aws_region = "ap-northeast-3"
#    source = "hardening-region"
#}

