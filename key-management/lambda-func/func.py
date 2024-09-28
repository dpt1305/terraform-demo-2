import json
import boto3
import os

s3 = boto3.client('s3')

def lambda_handler(event, context):
    return s3.put_object(
        Bucket=os.environ['S3_BUCKET'], 
        Key="cand_c3_l3_test_object_encrypted.txt", 
        Body=bytes("file contents of my file", 'utf-8'),
        ServerSideEncryption="aws:kms",
        SSEKMSKeyId=os.environ['KEY_ARN']
    )