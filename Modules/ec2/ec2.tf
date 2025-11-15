resource "aws_instance" "nginx" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  associate_public_ip_address = true

  tags = merge(var.common_tags, { "Name" = var.resource_name })

  user_data = templatefile("${path.module}/templates/user-data.sh", {})
}