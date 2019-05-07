provider "aws" {
  profile = "admin"
  region  = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket  = "nenad-terraform"
    key     = "state/website"
    region  = "eu-central-1"
    encrypt = true
  }
}
