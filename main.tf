provider "aws" {
  region = "us-east-1"
}

# Define the agency names
variable "agencies" {
  type    = string
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.agencies}-bucket"
  acl    = "private"
  
  tags = {
    Name        = "My Example Bucket"
    Environment = "Production"
  }
}
