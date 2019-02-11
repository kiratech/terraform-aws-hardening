resource "aws_s3_bucket" "aws_config" {
  bucket = "aws-config-${data.aws_caller_identity.current.account_id}"

  versioning {
    enabled = true
  }
}

resource "aws_iam_role" "aws_config" {
  name = "aws-config"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "aws_config" {
  name = "aws-config-delivery"
  role = "${aws_iam_role.aws_config.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.aws_config.arn}",
        "${aws_s3_bucket.aws_config.arn}/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "aws_config" {
  role       = "${aws_iam_role.aws_config.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}
