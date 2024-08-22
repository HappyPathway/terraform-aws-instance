data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "instance" {
  name               = lookup(var.required_tags, "Name")
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "instance" {
  name   = lookup(var.required_tags, "Name")
  role   = aws_iam_role.instance.id
  policy = var.iam_policy
}

resource "aws_iam_instance_profile" "instance" {
  name = lookup(var.required_tags, "Name")
  role = aws_iam_role.instance.name
}
