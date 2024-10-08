resource "aws_iam_role" "cand_c3_l3_ex2_write" {
    name = "cand-c3-l3-ex2-write"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "lambda.amazonaws.com"
            }
            # Resource = "*"
        },
        ]
    })

    tags = {
        tag-key = "udacity-role"
    }
}

data "aws_iam_policy" "AWSLambdaExecute" {
    name = "AWSLambdaExecute"
}
data "aws_iam_policy" "AmazonS3FullAccess" {
    name = "AmazonS3FullAccess"
}

resource "aws_iam_policy" "generate_data_by_key" {
  name        = "generate-data-by-key"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            
            Action = [
            "kms:GenerateDataKey",
            ]
            Effect   = "Allow"
            Resource = "*"
        },
        ]
    })
}

resource "aws_iam_role_policy_attachment" "test-attach-1" {
  role       = aws_iam_role.cand_c3_l3_ex2_write.name
  policy_arn = data.aws_iam_policy.AWSLambdaExecute.arn
}
resource "aws_iam_role_policy_attachment" "test-attach-2" {
  role       = aws_iam_role.cand_c3_l3_ex2_write.name
  policy_arn = data.aws_iam_policy.AmazonS3FullAccess.arn
}
resource "aws_iam_role_policy_attachment" "test-attach-5" {
  role       = aws_iam_role.cand_c3_l3_ex2_write.name
  policy_arn = aws_iam_policy.generate_data_by_key.arn
}