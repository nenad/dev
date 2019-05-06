resource "aws_iam_group_policy" "AWSLambdaFullAccess" {
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
  group  = "${aws_iam_group.website.id}"
  policy = "${data.aws_iam_policy_document.policy_gateway_admin.json}"
}

data "aws_iam_policy_document" "policy_gateway_admin" {
  statement {
    actions   = ["apigateway:*"]
    resources = ["*"]
  }
}
