resource "aws_s3_bucket" "main_bucket" {
    bucket = "trf-demo-bucket"

    tags = {
        Name        = "My bucket"
        Environment = "Dev"
    }
}