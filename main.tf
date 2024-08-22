# Description: This file is used to create the AWS resources using Terraform.
resource "aws_instance" "instance" {
  count                   = local.linux_instance ? var.instance_count : 0
  ami                     = var.ami
  instance_type           = var.instance_type
  disable_api_termination = tobool(var.troubleshoot)
  disable_api_stop        = tobool(var.troubleshoot)
  subnet_id               = var.subnet
  vpc_security_group_ids  = var.security_group_ids
  key_name                = aws_key_pair.deployer.key_name
  iam_instance_profile    = local.iam_instance_profile
  tags                    = var.required_tags

  root_block_device {
    delete_on_termination = var.root_block_device.delete_on_termination
    encrypted             = var.root_block_device.encrypted
    iops                  = var.root_block_device.iops
    kms_key_id            = var.root_block_device.kms_key_id
    tags                  = var.root_block_device.tags
    throughput            = var.root_block_device.throughput
    volume_size           = var.root_block_device.volume_size
    volume_type           = var.root_block_device.volume_type
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_devices
    content {
      delete_on_termination = ebs_block_device.value.delete_on_termination
      device_name           = ebs_block_device.value.device_name
      encrypted             = ebs_block_device.value.encrypted
      iops                  = ebs_block_device.value.iops
      kms_key_id            = ebs_block_device.value.kms_key_id
      snapshot_id           = ebs_block_device.value.snapshot_id
      tags                  = ebs_block_device.value.tags
      throughput            = ebs_block_device.value.throughput
      volume_size           = ebs_block_device.value.volume_size
      volume_type           = ebs_block_device.value.volume_type
    }
  }

  depends_on = [
    aws_key_pair.deployer
  ]
}

resource "null_resource" "linux_instance_provisioner" {
  for_each = local.linux_instance ? toset(aws_instance.instance) : toset([])
  connection {
    type        = "ssh"
    user        = var.ssh_user
    private_key = tls_private_key.ssh.private_key_pem
    host        = var.enable_public_ip ? each.value.public_ip : each.value.private_ip
  }

  provisioner "file" {
    source      = var.config.src
    destination = var.config.dest
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ${var.config.script}",
      "${var.config.script} ${var.config.args}"
    ]
  }
  depends_on = [aws_instance.instance]
}

resource "null_resource" "windows_instance_provisioner" {
  for_each = local.windows_instance ? toset(aws_instance.instance) : toset([])
  connection {
    type     = "winrm"
    user     = var.winrm_credentials.username
    password = var.winrm_credentials.password
    host     = var.enable_public_ip ? each.value.public_ip : each.value.private_ip
  }

  provisioner "file" {
    source      = var.config.src
    destination = var.config.dest
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ${var.config.script}",
      "${var.config.script} ${var.config.args}"
    ]
  }
  depends_on = [aws_instance.instance]
}
