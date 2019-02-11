output aws_config_bucket {
  value       = "${aws_s3_bucket.aws_config.bucket}"
  description = "The name of the S3 bucket used as AWS Config storage"
}

output aws_config_role_arn {
  value       = "${aws_iam_role.aws_config.arn}"
  description = "The ARN of the AWS Config role"
}

output aws_flowlogs_role_arn {
  value       = "${aws_iam_role.flowlogs.arn}"
  description = "The ARN of the VPC FlowLogs role"
}
