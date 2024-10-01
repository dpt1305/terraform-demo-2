import json
import boto3

s3 = boto3.client('s3')

def handler(event, context):
    bucket ='trf-demo-bucket-tungjj-20240929'

    transactionToUpload = {}
    transactionToUpload['transactionId'] = '12345'
    transactionToUpload['type'] = 'PURCHASE'
    transactionToUpload['amount'] = 20
    transactionToUpload['customerId'] = 'CID-11111'

    fileName = 'CID-11111' + '.json'

    return s3.put_object(
        Bucket= bucket,
        Key=fileName,
        Body=bytes(json.dumps(transactionToUpload).encode('UTF-8')),
        ServerSideEncryption="aws:kms",
        SSEKMSKeyId='11fc5526-044f-4700-b01b-0cb6fb9e564a'
    )