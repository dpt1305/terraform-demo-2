resource "aws_s3_bucket" "main_bucket" {
  bucket = "trf-demo-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "secondary_bucket" {
  bucket = "trf-demo-bucket-2"

  provider = aws.tokyo

  tags = {
    Name        = "My bucket 2"
    Environment = "Dev"
  }
}