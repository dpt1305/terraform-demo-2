resource "aws_s3_bucket" "main_bucket" {
    bucket = "cand-c3-s3-app1-tungjj"

    tags = {
        Name        = "cand-c3-s3-app1-tungjj"
        Environment = "Dev"
    }
}
resource "aws_s3_bucket" "limit_access_bucket" {
    bucket = "cand-c3-s3-offlimits-tungjj"

    tags = {
        Name        = "cand-c3-s3-offlimits-tungjj"
        Environment = "Dev"
    }
}