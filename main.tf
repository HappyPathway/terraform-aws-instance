resource "aws_instance" "linux" {
  count                   = local.linux_instance ? 1 : 0
  ami                     = data.aws_ssm_parameter.ami.value
  instance_type           = lookup(data.aws_ssm_parameter.params, "instance_type").value
  disable_api_termination = tobool(lookup(data.aws_ssm_parameter.params, "troubleshoot").value)
  disable_api_stop        = tobool(lookup(data.aws_ssm_parameter.params, "troubleshoot").value)
  subnet_id               = lookup(data.aws_ssm_parameter.params, "subnets").value
  vpc_security_group_ids  = split(",", lookup(data.aws_ssm_parameter.params, "security_group_ids").value)
  key_name                = aws_key_pair.deployer.key_name

  tags = {
    Name    = "${var.project_name}"
    Project = var.project_name
  }

  root_block_device {
    volume_size = 80
  }

  connection {
    type        = "ssh"
    user        = lookup(data.aws_ssm_parameter.params, "ssh_user").value
    private_key = tls_private_key.ssh.private_key_pem
    host        = self.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir /tmp/goss"
    ]
  }

  provisioner "file" {
    source      = "${var.goss_directory}/goss-files"
    destination = "/tmp/goss/goss-files"
  }

  provisioner "file" {
    source      = "${var.goss_directory}/dependencies"
    destination = "/tmp/goss/dependencies"
  }

  provisioner "local-exec" {
    command = "echo ${data.aws_ssm_parameter.ami.value} > tf_ami_id.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/goss/dependencies/goss"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "/tmp/goss/dependencies/goss -g /tmp/goss/goss-files/${local.goss_profile} validate"
    ]
  }

  provisioner "local-exec" {
    command = "rm tf_ami_id.txt"
  }

  depends_on = [
    aws_key_pair.deployer
  ]
}
