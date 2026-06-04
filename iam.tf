resource "aws_iam_group" "group" {
  name = "cmtr-3v98t79h-iam-group"

}

resource "aws_iam_policy" "policy" {
  name = "cmtr-3v98t79h-iam-policy"
  policy = templatefile("${path.module}/policy.json", {
    bucket_name = data.aws_s3_bucket.bucket.bucket
  })
  tags = {
    Project = "cmtr-3v98t79h"
  }
}

resource "aws_iam_group_policy_attachment" "group_policy_attachment" {
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.policy.arn

}

resource "aws_iam_role" "role" {
  name = "cmtr-3v98t79h-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Project = "cmtr-3v98t79h"
  }
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn

}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "cmtr-3v98t79h-iam-instance-profile"
  role = aws_iam_role.role.name

  tags = {
    Project = "cmtr-3v98t79h"
  }
}

  