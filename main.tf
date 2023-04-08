provider "aws" {
  region = "eu-west-1"
}

# Define the agency names
variable "agencies" {
  type    = list(string)
  default = ["agency-a"]
}

# Create the S3 bucket for each agency
resource "aws_s3_bucket" "agency_bucket" {
  count  = length(var.agencies)
  bucket = "${var.agencies[count.index]}-bucket"

  tags = {
    Name = "${var.agencies[count.index]}-bucket"
  }
}

# Set the ACL for each S3 bucket
resource "aws_s3_bucket_acl" "agency_bucket_acl" {
  count  = length(var.agencies)
  bucket = aws_s3_bucket.agency_bucket[count.index].id

  # Set the ACL to private and restrict file types
  acl = "private"
}

# Add lifecycle policy to move data to glacier after 90 days
resource "aws_s3_bucket_lifecycle_configuration" "agency_bucket_lifecycle" {
  count  = length(var.agencies)
  bucket = aws_s3_bucket.agency_bucket[count.index].id

  rule {
    id      = "move-to-glacier"
    status  = "Enabled"

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    filter {
      prefix = "/"
    }
  }
}


# Enable SSE for each S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "agency_bucket_sse" {
  count = length(var.agencies)
  bucket = aws_s3_bucket.agency_bucket[count.index].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Enable versioning for each S3 bucket
resource "aws_s3_bucket_versioning" "agency_bucket_versioning" {
  count = length(var.agencies)
  bucket = aws_s3_bucket.agency_bucket[count.index].id

  versioning_configuration {
    status = "Enabled"
  }
}
