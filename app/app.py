
import os
import boto3
from botocore.handlers import disable_signing
from botocore import UNSIGNED
from botocore.client import Config

if __name__ == "__main__":

    bucket_name = 'deutsche-boerse-xetra-pds'

    s3 = boto3.resource('s3')
    s3.meta.client.meta.events.register(
         'choose-signer.s3.*', disable_signing)

    s3_bucket = s3.Bucket(bucket_name)

    s3_client = boto3.client('s3', config=Config(signature_version=UNSIGNED))
    kwargs = {'Bucket': s3_bucket}

    os.mkdir('/tmp/deutsche-boerse-xetra-pds')

    for date_prefix in ['2019-01-17','2019-01-18','2019-01-19']:

        s3_response = s3_client.list_objects_v2(
            Bucket = bucket_name,
            Prefix = date_prefix,
            MaxKeys=500
        )

        for object in s3_response['Contents']:
            path, filename = os.path.split(object["Key"])

            s3_bucket.download_file(object["Key"], "/tmp/deutsche-boerse-xetra-pds/"+filename)





