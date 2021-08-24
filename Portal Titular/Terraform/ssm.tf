resource "aws_iam_role" "role_ssm_portal_titular" {
  name = "role_ssm_portal_titular"

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

resource "aws_iam_policy" "policy_ssm_portal_titular" {
  name        = "policy_portal_titular"
  description = "policy para acesso a instancias"

  policy = <<EOF
{
   "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeAssociation",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:GetDocument",
                "ssm:DescribeDocument",
                "ssm:GetManifest",
                "ssm:GetParameter",
                "ssm:GetParameters",
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:PutInventory",
                "ssm:PutComplianceItems",
                "ssm:PutConfigurePackageResult",
                "ssm:UpdateAssociationStatus",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateInstanceInformation"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
// Anexando politica AmazonSSMPatchAssociation a role
resource "aws_iam_role_policy_attachment" "ssm-attach-AmazonSSMPatchAssociation" {
  depends_on = [aws_iam_role.role_ssm_portal_titular,]
  role       = aws_iam_role.role_ssm_portal_titular.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
}
// Anexando politica AmazonSSMManagedInstanceCore a role 
resource "aws_iam_role_policy_attachment" "ssm-attach-AmazonSSMManagedInstanceCore" {
  depends_on = [aws_iam_role.role_ssm_portal_titular,]
  role       = aws_iam_role.role_ssm_portal_titular.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
// associando role a uma instancia
resource "aws_iam_instance_profile" "ec2_profile" {
  name  = "ec2_profile_portal_titualar_ssm"
  role = aws_iam_role.role_ssm_portal_titular.name
}

