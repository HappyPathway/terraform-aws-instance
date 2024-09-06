variable "ami" {
  description = "The AMI to use"
  type        = string
}

variable "config" {
  description = "Directory and script details for automation"
  type = object({
    src    = string
    dest   = string
    script = string
    args   = string
  })
  default = null
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use"
  type        = string
}

variable "security_group_ids" {
  description = "The security group ids to use"
  type        = list(string)
}

variable "ssh_user" {
  description = "The ssh user to use"
  type        = string
  default     = null
}

variable "subnet" {
  description = "List of subnet IDs"
  type        = string
}

variable "troubleshoot" {
  description = "Enable troubleshooting"
  type        = bool
}

variable "windows_instance" {
  description = "Create a Windows instance"
  type        = bool
}

variable "enable_public_ip" {
  description = "Enable public IP"
  type        = bool
  default     = false
}

variable "instance_count" {
  description = "The number of instances to create"
  type        = number
  default     = 1
}

variable "required_tags" {
  description = "The required tags for the resources"
  type        = map(string)
}

# The root_block_device block supports the following:
# delete_on_termination - (Optional) Whether the volume should be destroyed on instance termination. Defaults to true.
# encrypted - (Optional) Whether to enable volume encryption. Defaults to false. Must be configured to perform drift detection.
# iops - (Optional) Amount of provisioned IOPS. Only valid for volume_type of io1, io2 or gp3.
# kms_key_id - (Optional) Amazon Resource Name (ARN) of the KMS Key to use when encrypting the volume. Must be configured to perform drift detection.
# tags - (Optional) Map of tags to assign to the device.
# throughput - (Optional) Throughput to provision for a volume in mebibytes per second (MiB/s). This is only valid for volume_type of gp3.
# volume_size - (Optional) Size of the volume in gibibytes (GiB).
# volume_type - (Optional) Type of volume. Valid values include standard, gp2, gp3, io1, io2, sc1, or st1. Defaults to the volume type that the AMI uses.
variable "root_block_device" {
  type = object({
    delete_on_termination = optional(bool, true)
    encrypted             = optional(bool, false)
    iops                  = optional(number, null)
    kms_key_id            = optional(string, null)
    tags                  = optional(map(string), {})
    throughput            = optional(number, null)
    volume_size           = optional(number, 100)
    volume_type           = optional(string, "gp3")
  })
}



# Each ebs_block_device block supports the following:

# delete_on_termination - (Optional) Whether the volume should be destroyed on instance termination. Defaults to true.
# device_name - (Required) Name of the device to mount.
# encrypted - (Optional) Enables EBS encryption on the volume. Defaults to false. Cannot be used with snapshot_id. Must be configured to perform drift detection.
# iops - (Optional) Amount of provisioned IOPS. Only valid for volume_type of io1, io2 or gp3.
# kms_key_id - (Optional) Amazon Resource Name (ARN) of the KMS Key to use when encrypting the volume. Must be configured to perform drift detection.
# snapshot_id - (Optional) Snapshot ID to mount.
# tags - (Optional) Map of tags to assign to the device.
# throughput - (Optional) Throughput to provision for a volume in mebibytes per second (MiB/s). This is only valid for volume_type of gp3.
# volume_size - (Optional) Size of the volume in gibibytes (GiB).
# volume_type - (Optional) Type of volume. Valid values include standard, gp2, gp3, io1, io2, sc1, or st1. Defaults to gp2.
variable "ebs_block_devices" {
  description = "The EBS block devices to attach"
  type = list(object({
    delete_on_termination = optional(bool, true)
    device_name           = string
    encrypted             = optional(bool, false)
    iops                  = optional(number, null)
    kms_key_id            = optional(string, null)
    snapshot_id           = optional(string, null)
    tags                  = optional(map(string), {})
    throughput            = optional(number, null)
    volume_size           = optional(number, 100)
    volume_type           = optional(string, "gp2")
  }))
  default = []
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to use"
  type        = string
  default     = null
}

variable "iam_policy" {
  description = "The IAM policy to use"
  type        = string
  default     = null
}

variable "winrm_credentials" {
  description = "The winrm credentials"
  type = object({
    username = string
    password = string
  })
  default = null
}

variable "store_key" {
  description = "Store the key in secrets manager"
  type        = bool
  default     = false
}

variable "secret_path" {
  description = "The secret path"
  type        = string
  default     = null
}

variable "user_data_replace_on_change" {
  type    = bool
  default = false
}

variable "user_data" {
  type    = string
  default = null
}
