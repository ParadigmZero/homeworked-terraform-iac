variable "bucket_name" {
  description = "S3 bucket name for HomeWorked"
  type = string
  default = "homeworked2"
}

variable "region" {
  description = "Region for HomeWorked S3 bucket and associated objects"
  type = string
  default = "eu-west-1"
}