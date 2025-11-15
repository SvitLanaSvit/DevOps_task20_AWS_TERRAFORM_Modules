output "instance_public_ip" {
  value = aws_instance.nginx.public_ip
  description = "Public IP of the created EC2 instance"
}
