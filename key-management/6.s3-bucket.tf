resource "aws_s3_bucket" "main_bucket" {
    bucket = "trf-demo-bucket-tungjj-20240929"

    tags = {
        Name        = "My bucket"
        Environment = "Dev"
    }
}