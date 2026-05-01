resource "aws_iam_role" "tf_ec2_role" {
  name = "tf_ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "tf_ec2_role_attachments" {
  for_each   = local.tf_ec2_role_policies
  role       = aws_iam_role.tf_ec2_role.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "tf_ec2_profile" {
  name = "tf_ec2_profile"
  role = aws_iam_role.tf_ec2_role.name
}

resource "aws_iam_role" "tf_jenkins_role" {
  name = "tf_jenkins_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "tf_jenkins_role_attachments" {
  for_each   = local.tf_jenkins_role_policies
  role       = aws_iam_role.tf_jenkins_role.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "tf_jenkins_profile" {
  name = "tf_jenkins_profile"
  role = aws_iam_role.tf_jenkins_role.name
}
