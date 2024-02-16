terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}

provider "aws" {
  region                   = var.region
  shared_config_files      = ["$HOME/.aws/config "]
  shared_credentials_files = ["$HOME/.aws/credentials"]
}

resource "aws_s3_bucket" "homeworked_bucket" {
  bucket = var.bucket_name
  tags = {
    Name = "homeworked"
  }
}

resource "aws_s3_bucket_public_access_block" "homeworked_bucket_public_access" {
  bucket = aws_s3_bucket.homeworked_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "homeworked_bucket_policy" {
  bucket = aws_s3_bucket.homeworked_bucket.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::homeworked/*",
                "arn:aws:s3:::homeworked"
            ]
        }
    ]
}
EOF


depends_on = [aws_s3_bucket_public_access_block.homeworked_bucket_public_access]
}

resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = aws_s3_bucket.homeworked_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["POST", "GET", "PUT", "DELETE", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
  }
}

resource "aws_s3_object" "homeworked_images" {
  tags = {
    Name = "homeworked"
  }
  bucket       = aws_s3_bucket.homeworked_bucket.id
  for_each     = fileset("objects/", "**/*.*")
  key          = each.value
  source       = "objects/${each.value}"
  content_type = "image/png"
}
