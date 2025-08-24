# AWS Infrastructure Automation Project

This project automates the provisioning and management of core AWS resources using Terraform and Python. It includes modular Terraform code for creating EC2 instances, VPCs, and S3 buckets, as well as Python scripts utilizing Boto3 for operational automation.

## Project Structure

```
aws-infra-automation
├── terraform
│   ├── modules
│   │   ├── ec2
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── vpc
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── s3
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── provider.tf
├── python
│   ├── scripts
│   │   ├── manage_ec2.py
│   │   ├── manage_s3.py
│   │   └── manage_vpc.py
│   └── requirements.txt
└── README.md
```

## Prerequisites

- Terraform installed on your machine.
- Python 3.x installed along with pip.
- AWS account with appropriate permissions to create resources.

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd aws-infra-automation
   ```

2. **Terraform Setup**
   - Navigate to the `terraform` directory.
   - Initialize Terraform:
     ```bash
     terraform init
     ```
   - Review the configuration:
     ```bash
     terraform plan
     ```
   - Apply the configuration to provision resources:
     ```bash
     terraform apply
     ```

3. **Python Setup**
   - Navigate to the `python` directory.
   - Install the required Python packages:
     ```bash
     pip install -r requirements.txt
     ```

## Usage

### Terraform Modules

- **EC2 Module**: Provision EC2 instances by modifying the variables in `terraform/modules/ec2/variables.tf`.
- **VPC Module**: Create a VPC and subnets by adjusting the settings in `terraform/modules/vpc/variables.tf`.
- **S3 Module**: Set up S3 buckets by changing the configurations in `terraform/modules/s3/variables.tf`.

### Python Scripts

- **Manage EC2 Instances**: Use `manage_ec2.py` to start, stop, or terminate EC2 instances.
- **Manage S3 Buckets**: Use `manage_s3.py` to clean up old objects in S3 buckets.
- **Manage VPC Resources**: Use `manage_vpc.py` to tag or monitor VPC resources.

## Outputs

After running `terraform apply`, you will receive outputs such as instance IDs, public IPs, VPC IDs, and S3 bucket names, which can be used for further management or automation.

## Conclusion

This project provides a comprehensive solution for automating AWS infrastructure using Terraform and Python. Modify the configurations as needed to fit your specific requirements.