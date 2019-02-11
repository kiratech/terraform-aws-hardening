resource "aws_flow_log" "default" {
  log_destination = "${aws_cloudwatch_log_group.flowlogs_default.arn}"
  iam_role_arn    = "${var.aws_flowlogs_role_arn}"
  vpc_id          = "${aws_default_vpc.default.id}"
  traffic_type    = "REJECT"
}

resource "aws_cloudwatch_log_group" "flowlogs_default" {
  name              = "default-vpc-flowlogs"
  retention_in_days = 365
}
