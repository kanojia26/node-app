provider "aws" {
  region = "${var.region}"
}
terraform {
  backend "s3" {
    bucket = "abhi-terraform-state"
    key    = "abhi.tfstate"
    region = "ap-southeast-1"
    encrypt = true
  }
}
data "terraform_remote_state" "state" {
  backend = "s3"
  config {
    bucket     = "abhi-terraform-state"
    region     = "ap-southeast-1"
    key        = "abhi.tfstate"
  }
}
