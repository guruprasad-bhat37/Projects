import boto3
import os
import json
from datetime import datetime

ec2 = boto3.client("ec2")
s3 = boto3.client("s3")

INSTANCE_IDS = os.getenv("INSTANCE_IDS", "").split(",")
LOG_BUCKET = os.getenv("LOG_BUCKET")

def lambda_handler(event, context):
    action = event.get("action", "").lower()
    now = datetime.utcnow().isoformat()

    if action == "start":
        ec2.start_instances(InstanceIds=INSTANCE_IDS)
        log = {"time": now, "action": "start", "instances": INSTANCE_IDS}
    elif action == "stop":
        ec2.stop_instances(InstanceIds=INSTANCE_IDS)
        log = {"time": now, "action": "stop", "instances": INSTANCE_IDS}
    else:
        log = {"time": now, "action": "invalid", "message": "use start or stop"}

    # Save log to S3
    if LOG_BUCKET:
        key = f"logs/{now}-{action}.json"
        s3.put_object(Bucket=LOG_BUCKET, Key=key, Body=json.dumps(log))

    return log
