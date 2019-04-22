
resource "aws_lambda_function" "process" {
  function_name    = "${var.application}-${var.function_name}"
  role             = "${aws_iam_role.default.arn}"
  timeout          = 60
  memory_size      = 1024
  handler          = "index.handler"
  runtime          = "nodejs8.10"
  s3_bucket        = "avengers-demo"
  s3_key           = "${var.lambda_version}/getLambda.zip"
}

resource "aws_lambda_event_source_mapping" "kinesis" {
  batch_size        = 50
  event_source_arn  = "${var.stream_arn}"
  enabled           = true
  function_name     = "${aws_lambda_function.process.arn}"
  starting_position = "TRIM_HORIZON"
}

output "process_arn" {
  value = "${aws_lambda_function.process.arn}"

}
