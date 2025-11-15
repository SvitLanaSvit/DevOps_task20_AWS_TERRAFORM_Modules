module "network" {
  source            = "../../../modules/network"
  vpc_id            = data.aws_vpc.default.id
  list_of_open_ports = [80, 443]
  resource_name     = local.resource_name //"nginx-network"
  common_tags       = local.common_tags
}

module "ec2" {
  source            = "../../../modules/ec2"
  vpc_id            = data.aws_vpc.default.id
  subnet_id         = data.aws_subnet.default.id
  security_group_id = module.network.security_group_id
  ami_id            = data.aws_ami.ubuntu.id
  instance_type     = var.instance_type
  resource_name     = local.resource_name //"nginx-ec2"
  common_tags       = local.common_tags
}
