resource "aws_iam_group_policy" "AWSLambdaFullAccess" {
  name   = "aws_lambda_full_access"
  group  = "${aws_iam_group.website.id}"
  policy = "${data.aws_iam_policy_document.policy_lambda_admin.json}"
}

data "aws_iam_policy_document" "policy_lambda_admin" {
  statement {
    actions   = ["lambda:*"]
    resources = ["*"]
  }
}

resource "aws_iam_group_policy" "AmazonAPIGatewayAdministrator" {
  name   = "aws_apigateway_admin"
  group  = "${aws_iam_group.website.id}"
  policy = "${data.aws_iam_policy_document.policy_gateway_admin.json}"
}

data "aws_iam_policy_document" "policy_gateway_admin" {
  statement {
    actions   = ["apigateway:*"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "policy_website_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}

resource "aws_cloudwatch_log_group" "AmazonCloudwatchLogGroup" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_website.function_name}"
  retention_in_days = 14
}

resource "aws_iam_policy" "policy_lambda" {
  name        = "policy_iam_lambda_logs"
  path        = "/"
  description = "IAM Policy for lambda logs"
  policy      = "${data.aws_iam_policy_document.policy_lambda_log.json}"
}

data "aws_iam_policy_document" "policy_lambda_log" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_iam_role_policy_attachment" "lambda_iam_role_policy_attachment" {
  policy_arn = "${aws_iam_policy.policy_lambda.arn}"
  role       = "${aws_iam_role.website_role.name}"
}

resource "aws_cloudwatch_log_stream" "lambda_logs" {
  name           = "${aws_lambda_function.lambda_website.function_name}"
  log_group_name = "${aws_cloudwatch_log_group.AmazonCloudwatchLogGroup.name}"
}
