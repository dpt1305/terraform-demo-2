import json
import boto3
import os

s3 = boto3.client('s3')

def handler(event, context):
    bucket ='trf-demo-bucket-tungjj-20240929'
    fileName = 'CID-11111' + '.json'
    response =  s3.get_object(
        Bucket=bucket, 
        Key=fileName, 
    )
    print(response['Body'].read())

    return