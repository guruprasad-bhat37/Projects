# Automated EC2 Instance Scheduler using Lambda, EventBridge, and S3

This project automatically starts and stops EC2 instances on a schedule, and saves logs to S3.

## How It Works
- **AWS Lambda (Python + Boto3)** starts/stops EC2
- **Amazon EventBridge** triggers Lambda at scheduled times
- **Amazon S3** stores JSON logs of each action
- **Terraform** provisions resources

