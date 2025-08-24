variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "tags" {
  description = "Tags to assign to the EC2 instance"
  type        = map(string)
  default     = {
    Name = "Terraform-EC2"
  }
}