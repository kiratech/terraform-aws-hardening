variable "aws_region" {
  type        = "string"
  description = "The name of the AWS region"
}

variable "aws_config_bucket" {
  type        = "string"
  description = "The name of the S3 bucket used as AWS Config storage"
}

variable "aws_config_role_arn" {
  type        = "string"
  description = "The ARN of the AWS Config role"
}

variable "aws_flowlogs_role_arn" {
  type        = "string"
  description = "The ARN of the VPC FlowLogs role"
}
