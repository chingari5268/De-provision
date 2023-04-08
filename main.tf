provider "aws" {
  region = "us-east-1"
}

# Define the agency names
variable "agencies" {
  type    = string
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.agencies}-bucket"
  
  tags = {
    Name        = "My Example Bucket"
    Environment = "Production"
  }
}

# Set the ACL for the S3 bucket
resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.id

  # Set the ACL to private
  # See https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl for more options
  acl = "private"
}
