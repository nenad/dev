resource "aws_lambda_function" "lambda_website" {
  function_name = "handle_request"
  handler       = "website"
  role          = "${aws_iam_role.website_role.arn}"
  runtime       = "go1.x"
  filename      = "website.zip"
}
