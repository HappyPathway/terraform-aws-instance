resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "${var.project_name}-deployer-key"
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "aws_secretsmanager_secret" "ssh_key" {
  count = local.linux_instance && var.store_key ? 1 : 0
  name  = var.secret_path
}

resource "aws_secretsmanager_secret_version" "ssh_key" {
  count         = local.linux_instance && var.store_key ? 1 : 0
  secret_id     = one(aws_secretsmanager_secret.ssh_key).id
  secret_string = tls_private_key.ssh.private_key_pem
}
