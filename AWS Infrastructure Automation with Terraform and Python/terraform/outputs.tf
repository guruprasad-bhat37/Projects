resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = var.tags
}

output "instance_id" {
  value = aws_instance.example.id
}

output "public_ip" {
  value = aws_instance.example.public_ip
}