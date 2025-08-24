provider "aws" {
  region = "us-east-1"
}

variable "instance_ids" {
  default = ["i-0123456789abcdef0"] # replace with your EC2 instance ID
}

# S3 bucket for logs
resource "aws_s3_bucket" "logs" {
  bucket = "ec2-scheduler-logs-12345"
  force_destroy = true
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "ec2-scheduler-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "ec2_full" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "s3_full" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Package Lambda
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function.zip"
}

# Lambda function
resource "aws_lambda_function" "scheduler" {
  function_name = "ec2-scheduler"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      INSTANCE_IDS = join(",", var.instance_ids)
      LOG_BUCKET   = aws_s3_bucket.logs.bucket
    }
  }
}

# EventBridge rules
resource "aws_cloudwatch_event_rule" "start_rule" {
  name                = "ec2-start-rule"
  schedule_expression = "cron(0 3 ? * MON-FRI *)" # 9AM IST
}

resource "aws_cloudwatch_event_rule" "stop_rule" {
  name                = "ec2-stop-rule"
  schedule_expression = "cron(0 12 ? * MON-FRI *)" # 6PM IST
}

resource "aws_cloudwatch_event_target" "start_target" {
  rule      = aws_cloudwatch_event_rule.start_rule.name
  target_id = "StartEC2"
  arn       = aws_lambda_function.scheduler.arn
  input     = jsonencode({ action = "start" })
}

resource "aws_cloudwatch_event_target" "stop_target" {
  rule      = aws_cloudwatch_event_rule.stop_rule.name
  target_id = "StopEC2"
  arn       = aws_lambda_function.scheduler.arn
  input     = jsonencode({ action = "stop" })
}

# Permissions for EventBridge to invoke Lambda
resource "aws_lambda_permission" "allow_start" {
  statement_id  = "AllowStart"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.scheduler.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.start_rule.arn
}

resource "aws_lambda_permission" "allow_stop" {
  statement_id  = "AllowStop"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.scheduler.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop_rule.arn
}
