//Criaçaõ de role com policy de relação de confiança
resource "aws_iam_role" "role_ssm_quality_manager" {
  name = "role_ssm_quality_manager"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

// Anexando politica AmazonSSMPatchAssociation a role
resource "aws_iam_role_policy_attachment" "ssm-attach-AmazonSSMPatchAssociation" {
  depends_on = [aws_iam_role.role_ssm_quality_manager,]
  role       = aws_iam_role.role_ssm_quality_manager.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
}
// Anexando politica AmazonSSMManagedInstanceCore a role 
resource "aws_iam_role_policy_attachment" "ssm-attach-AmazonSSMManagedInstanceCore" {
  depends_on = [aws_iam_role.role_ssm_quality_manager,]
  role       = aws_iam_role.role_ssm_quality_manager.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
// associando role a uma instancia
resource "aws_iam_instance_profile" "ec2_profile" {
  name  = "ec2_profile_ssm"
  role = aws_iam_role.role_ssm_quality_manager.name
}

