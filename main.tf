terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}

provider "aws" {
    region = "${var.region}"
    shared_config_files = ["$HOME/.aws/config " ]
    shared_credentials_files = ["$HOME/.aws/credentials"]
}

resource "aws_s3_bucket" "homeworked-bucket" {
    bucket = "${var.bucket_name}"
}

resource "aws_s3_object" "images" {
  bucket = aws_s3_bucket.homeworked-bucket.id
  for_each = fileset("assets/", "**/*.*")
  key = each.value
  source = "assets/${each.value}"
  content_type = each.value
}
