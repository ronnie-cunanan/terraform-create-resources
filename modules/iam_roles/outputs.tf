output "tf_ec2_role_name" {
  description = "Name of the EC2 IAM role."
  value       = aws_iam_role.tf_ec2_role.name
}

output "tf_ec2_instance_profile_name" {
  description = "Name of the EC2 instance profile."
  value       = aws_iam_instance_profile.tf_ec2_profile.name
}

output "tf_jenkins_role_name" {
  description = "Name of the Jenkins IAM role."
  value       = aws_iam_role.tf_jenkins_role.name
}

output "tf_jenkins_instance_profile_name" {
  description = "Name of the Jenkins instance profile."
  value       = aws_iam_instance_profile.tf_jenkins_profile.name
}
