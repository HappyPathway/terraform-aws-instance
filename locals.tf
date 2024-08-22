locals {
  linux_instance       = var.ssh_user == null ? false : true
  windows_instance     = var.windows_instance
  iam_instance_profile = var.iam_instance_profile ? var.iam_instance_profile : var.iam_policy == null ? null : aws_iam_instance_profile.instance.name
}
