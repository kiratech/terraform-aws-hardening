# Bucket for CloudTrail storage
resource "aws_s3_bucket" "cloudtrail" {
  bucket = "cloudtrail-${data.aws_caller_identity.current.account_id}"

  logging {
    target_bucket = "${aws_s3_bucket.cloudtrail_logging.id}"
    target_prefix = "cloudtrail/"
  }

  versioning {
    enabled = true
  }
}

# Bucket for Cloudtrail storage logging
resource "aws_s3_bucket" "cloudtrail_logging" {
  bucket = "cloudtrail-logging-${data.aws_caller_identity.current.account_id}"
  acl    = "log-delivery-write"

  versioning {
    enabled = true
  }
}

# Cloudtrail bucket policy
resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = "${aws_s3_bucket.cloudtrail.id}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${aws_s3_bucket.cloudtrail.id}/*",
            "Condition": {
              "StringEquals": {
                "s3:x-amz-acl": "bucket-owner-full-control"
              }
            }
        },
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::${aws_s3_bucket.cloudtrail.id}"
        }
    ]
}
POLICY
}

# CloudWatch Log group for CloudTrail
resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = "cloudtrail/default"
  retention_in_days = 365
}

# IAM role for CloudTrail -> CloudWatch
resource "aws_iam_role" "cloudtrail_cloudwatch" {
  name = "cloudtrail_cloudwatch"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement":[
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "cloudtrail_cloudwatch" {
  name = "cloudtrail_cloudwatch"
  path = "/"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailCreateLogStream20141101",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream"
            ],
            "Resource": [
                "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:${aws_cloudwatch_log_group.cloudtrail.name}:log-stream:${data.aws_caller_identity.current.account_id}_CloudTrail_us-east-1*"
            ]
        },
        {
            "Sid": "AWSCloudTrailPutLogEvents20141101",
            "Effect": "Allow",
            "Action": [
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:${aws_cloudwatch_log_group.cloudtrail.name}:log-stream:${data.aws_caller_identity.current.account_id}_CloudTrail_us-east-1*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "cloudtrail_cloudwatch" {
  role       = "${aws_iam_role.cloudtrail_cloudwatch.name}"
  policy_arn = "${aws_iam_policy.cloudtrail_cloudwatch.arn}"
}

resource "aws_cloudtrail" "default" {
  name                          = "default-trail"
  s3_bucket_name                = "${aws_s3_bucket.cloudtrail.id}"
  s3_key_prefix                 = "default"
  enable_logging                = true
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  cloud_watch_logs_role_arn     = "${aws_iam_role.cloudtrail_cloudwatch.arn}"
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudtrail.arn}"
  kms_key_id                    = "${aws_kms_key.cloudtrail.arn}"
}

# KMS key for CloudTrail log encryption
resource "aws_kms_key" "cloudtrail" {
  description             = "CloudTrail KMS key"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Id": "CloudTrail KMS Key Policy",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {"AWS": [
                "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            ]},
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow CloudTrail to encrypt logs",
            "Effect": "Allow",
            "Principal": {"Service": ["cloudtrail.amazonaws.com"]},
            "Action": "kms:GenerateDataKey*",
            "Resource": "*",
            "Condition": {"StringLike": {"kms:EncryptionContext:aws:cloudtrail:arn": "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"}}
        },
        {
            "Sid": "Allow CloudTrail to describe key",
            "Effect": "Allow",
            "Principal": {"Service": ["cloudtrail.amazonaws.com"]},
            "Action": "kms:DescribeKey",
            "Resource": "*"
        },
        {
            "Sid": "Allow principals in the account to decrypt log files",
            "Effect": "Allow",
            "Principal": {"AWS": "*"},
            "Action": [
                "kms:Decrypt",
                "kms:ReEncryptFrom"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {"kms:CallerAccount": "${data.aws_caller_identity.current.account_id}"},
                "StringLike": {"kms:EncryptionContext:aws:cloudtrail:arn": "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"}
            }
        },
        {
            "Sid": "Allow alias creation during setup",
            "Effect": "Allow",
            "Principal": {"AWS": "*"},
            "Action": "kms:CreateAlias",
            "Resource": "*",
            "Condition": {"StringEquals": {
                "kms:ViaService": "ec2.region.amazonaws.com",
                "kms:CallerAccount": "${data.aws_caller_identity.current.account_id}"
            }}
        }
    ]
}
EOF
}

resource "aws_kms_alias" "cloudtrail" {
  name          = "alias/cloudtrail"
  target_key_id = "${aws_kms_key.cloudtrail.key_id}"
}
