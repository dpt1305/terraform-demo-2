resource "aws_s3_bucket" "main_bucket" {
  bucket = "trf-demo-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_lifecycle_rule" {
    bucket = aws_s3_bucket.main_bucket.id
    
    rule {
        id = "expired-after-1day"
     
        expiration {
          days = 1
        }
     
        filter {
          and {
            prefix = "temp_file/"
            tags = {
              rule = "expired_after_1d"
              autoclean = "true"
            }
          }
        }
        status = "Enabled"
    }
}
