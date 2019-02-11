resource "aws_config_delivery_channel" "default" {
  name           = "default"
  depends_on     = ["aws_config_configuration_recorder.default"]
  s3_bucket_name = "${var.aws_config_bucket}"
  s3_key_prefix  = "config"
}

resource "aws_config_configuration_recorder" "default" {
  name     = "default"
  role_arn = "${var.aws_config_role_arn}"

  # Includes global resources (on a single region Config object)
  recording_group {
    include_global_resource_types = "${var.aws_region == "us-east-1" ? true : false }"
    all_supported                 = true
  }
}

resource "aws_config_configuration_recorder_status" "default" {
  name       = "${aws_config_configuration_recorder.default.name}"
  is_enabled = true
  depends_on = ["aws_config_delivery_channel.default"]
}
