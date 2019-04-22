variable "application" {
  description = "Application name"
}

resource "aws_kinesis_stream" "products-lifecycle" {
  name             = "${var.application}-products-lifecycle-stream"
  shard_count      = 1
  retention_period = 48                                             # 2 days

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  tags {
    Application = "${var.application}"
  }
}

output "products_lifecycle_stream_arn" {
  value = "${aws_kinesis_stream.products-lifecycle.arn}"
}

#####IAM ROLE
###############COGNITO ROLE
resource "aws_iam_role" "cognito-me" {
  name = "${var.application}-cog-iam-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "cognito-sync.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "cognito-me-policy" {
  name = "cognito_policy"
  role = "${aws_iam_role.cognito-me.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "kinesis:PutRecord"
      ],
      "Resource": "${aws_kinesis_stream.products-lifecycle.arn}"
      
    }
  ]
}
EOF
}

