resource "aws_s3_bucket" "nenad-terraform" {
  bucket = "nenad-terraform"
  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
