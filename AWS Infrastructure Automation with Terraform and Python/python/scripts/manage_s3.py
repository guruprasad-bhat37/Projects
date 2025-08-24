import boto3
import argparse
from datetime import datetime, timedelta

def cleanup_old_objects(bucket_name, days):
    s3 = boto3.client('s3')
    cutoff_date = datetime.now() - timedelta(days=days)

    response = s3.list_objects_v2(Bucket=bucket_name)

    if 'Contents' in response:
        for obj in response['Contents']:
            obj_date = obj['LastModified']
            if obj_date < cutoff_date:
                print(f"Deleting {obj['Key']} from {bucket_name} (Last Modified: {obj_date})")
                s3.delete_object(Bucket=bucket_name, Key=obj['Key'])
    else:
        print(f"No objects found in bucket {bucket_name}.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Manage S3 bucket operations.')
    parser.add_argument('bucket_name', type=str, help='The name of the S3 bucket.')
    parser.add_argument('days', type=int, help='Delete objects older than this many days.')

    args = parser.parse_args()
    cleanup_old_objects(args.bucket_name, args.days)