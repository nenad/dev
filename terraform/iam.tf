resource "aws_iam_group" "website" {
  name = "website"
  path = "/"
}

resource "aws_iam_user" "nenad_dev" {
  name = "nenad_dev"
  path = "/"
}

resource "aws_iam_user_group_membership" "website_nenad_dev" {
  user   = "${aws_iam_user.nenad_dev.name}"
  groups = ["${aws_iam_group.website.id}"]
}

resource "aws_iam_role" "website_role" {
  name               = "website_role"
  assume_role_policy = "${data.aws_iam_policy_document.policy_website_role.json}"
}
