terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
    
    // NOTE: can use remote server to save .tfstate on the server
    // NOTE: can use with S3 bucket and versioning bucket
    backend "s3" {
        bucket = "udacity-bucket-tungjj"
        key = "project.tfstate" 
        region = "us-east-1"
    }
}

provider "aws" {
    region                   = "us-east-1"
    shared_credentials_files = ["~/.aws/credentials"]
    profile                  = "default"
}
