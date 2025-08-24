# Automated EC2 Instance Scheduler using Lambda, EventBridge, and S3

This project automates the daily start and stop of EC2 instances using AWS Lambda and EventBridge, with centralized logging to S3. All infrastructure is provisioned using Terraform.

## Features

- **Automated Scheduling:** EC2 instances are started and stopped at defined times using EventBridge cron rules.
- **Serverless Automation:** AWS Lambda (Python + Boto3) performs EC2 actions.
- **Centralized Logging:** Lambda writes JSON logs of each action to an S3 bucket for audit and monitoring.
- **Infrastructure-as-Code:** All AWS resources (EC2, Lambda, IAM, EventBridge, S3) are provisioned and managed via Terraform.

## Architecture

```
EventBridge (Scheduled Rule)
        |
        v
    Lambda Function (Python)
        |
        v
    EC2 Start/Stop + Log to S3
```

## Project Structure

```
Automated EC2 Instance Scheduler using Lambda and EventBridge/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── iam.tf
│   ├── lambda.tf
│   ├── eventbridge.tf
│   └── s3.tf
├── lambda/
│   └── ec2_scheduler.py
└── README.md
```

## Prerequisites

- AWS account with permissions for EC2, Lambda, IAM, S3, and EventBridge.
- [Terraform](https://www.terraform.io/downloads.html) installed.
- [Python 3.x](https://www.python.org/downloads/) installed (for Lambda code).
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) configured (optional for testing).

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd "Automated EC2 Instance Scheduler using Lambda and EventBridge"
   ```

2. **Prepare Lambda Deployment Package**
   ```bash
   cd lambda
   zip ec2_scheduler.zip ec2_scheduler.py
   cd ..
   ```

3. **Deploy Infrastructure with Terraform**
   ```bash
   cd terraform
   terraform init
   terraform apply
   ```

## Usage

- **Scheduling:** By default, EC2 instances are started at 6 AM UTC and stopped at 6 PM UTC. Adjust cron expressions in `eventbridge.tf` as needed.
- **Logging:** Each Lambda execution writes a JSON log to the S3 bucket under the `ec2-scheduler-logs/` prefix.
- **Customization:** Change EC2 instance filters or tags in `ec2_scheduler.py` to target specific instances.

## Outputs

After deployment, Terraform will output:
- EC2 instance ID and public IP
- S3 bucket name for logs

## Clean Up

To remove all resources:
```bash
terraform destroy
```

## License

MIT License

---

**This project demonstrates serverless automation, event-driven scheduling, centralized logging, and infrastructure-as-code best practices on AWS.**