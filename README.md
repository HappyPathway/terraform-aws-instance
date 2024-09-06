# terraform-aws-instance
Terraform Workspace

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.62.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.62.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.2 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_instance.linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_secretsmanager_secret.ssh_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.ssh_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [null_resource.linux_instance_provisioner](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [tls_private_key.ssh](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | The AMI to use | `string` | n/a | yes |
| <a name="input_config"></a> [config](#input\_config) | Directory and script details for automation | <pre>object({<br>    src    = string<br>    dest   = string<br>    script = string<br>    args   = string<br>  })</pre> | `null` | no |
| <a name="input_ebs_block_devices"></a> [ebs\_block\_devices](#input\_ebs\_block\_devices) | The EBS block devices to attach | <pre>list(object({<br>    delete_on_termination = optional(bool, true)<br>    device_name           = string<br>    encrypted             = optional(bool, false)<br>    iops                  = optional(number, null)<br>    kms_key_id            = optional(string, null)<br>    snapshot_id           = optional(string, null)<br>    tags                  = optional(map(string), {})<br>    throughput            = optional(number, null)<br>    volume_size           = optional(number, 100)<br>    volume_type           = optional(string, "gp2")<br>  }))</pre> | `[]` | no |
| <a name="input_enable_public_ip"></a> [enable\_public\_ip](#input\_enable\_public\_ip) | Enable public IP | `bool` | `false` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | The IAM instance profile to use | `string` | `null` | no |
| <a name="input_iam_policy"></a> [iam\_policy](#input\_iam\_policy) | The IAM policy to use | `string` | `null` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | The number of instances to create | `number` | `1` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance type to use | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the project | `string` | n/a | yes |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | The required tags for the resources | `map(string)` | n/a | yes |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | The root\_block\_device block supports the following: delete\_on\_termination - (Optional) Whether the volume should be destroyed on instance termination. Defaults to true. encrypted - (Optional) Whether to enable volume encryption. Defaults to false. Must be configured to perform drift detection. iops - (Optional) Amount of provisioned IOPS. Only valid for volume\_type of io1, io2 or gp3. kms\_key\_id - (Optional) Amazon Resource Name (ARN) of the KMS Key to use when encrypting the volume. Must be configured to perform drift detection. tags - (Optional) Map of tags to assign to the device. throughput - (Optional) Throughput to provision for a volume in mebibytes per second (MiB/s). This is only valid for volume\_type of gp3. volume\_size - (Optional) Size of the volume in gibibytes (GiB). volume\_type - (Optional) Type of volume. Valid values include standard, gp2, gp3, io1, io2, sc1, or st1. Defaults to the volume type that the AMI uses. | <pre>object({<br>    delete_on_termination = optional(bool, true)<br>    encrypted             = optional(bool, false)<br>    iops                  = optional(number, null)<br>    kms_key_id            = optional(string, null)<br>    tags                  = optional(map(string), {})<br>    throughput            = optional(number, null)<br>    volume_size           = optional(number, 100)<br>    volume_type           = optional(string, "gp3")<br>  })</pre> | n/a | yes |
| <a name="input_secret_path"></a> [secret\_path](#input\_secret\_path) | The secret path | `string` | `null` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | The security group ids to use | `list(string)` | n/a | yes |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | The ssh user to use | `string` | `null` | no |
| <a name="input_store_key"></a> [store\_key](#input\_store\_key) | Store the key in secrets manager | `bool` | `false` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | List of subnet IDs | `string` | n/a | yes |
| <a name="input_troubleshoot"></a> [troubleshoot](#input\_troubleshoot) | Enable troubleshooting | `bool` | n/a | yes |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | n/a | `string` | `null` | no |
| <a name="input_user_data_replace_on_change"></a> [user\_data\_replace\_on\_change](#input\_user\_data\_replace\_on\_change) | n/a | `bool` | `false` | no |
| <a name="input_windows_instance"></a> [windows\_instance](#input\_windows\_instance) | Create a Windows instance | `bool` | n/a | yes |
| <a name="input_winrm_credentials"></a> [winrm\_credentials](#input\_winrm\_credentials) | The winrm credentials | <pre>object({<br>    username = string<br>    password = string<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_data"></a> [key\_data](#output\_key\_data) | n/a |
| <a name="output_linux_hosts"></a> [linux\_hosts](#output\_linux\_hosts) | n/a |
| <a name="output_linux_ssh"></a> [linux\_ssh](#output\_linux\_ssh) | n/a |
<!-- END_TF_DOCS -->