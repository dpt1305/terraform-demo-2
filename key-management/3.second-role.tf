resource "aws_iam_role" "cand_c3_l3_ex2_read" {
    name = "cand-c3-l3-ex2-read"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "lambda.amazonaws.com"
            }
        },
        ]
    })

    tags = {
        tag-key = "udacity-role"
    }
}
resource "aws_iam_policy" "decrypt_data_by_key" {
  name        = "decrypt-data-by-key"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            
            Action = [
            "kms:Decrypt",
            ]
            Effect   = "Allow"
            Resource = "*"
        },
        ]
    })
}

data "aws_iam_policy" "AmazonS3ReadOnlyAccess" {
    name = "AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "test-attach-3" {
  role       = aws_iam_role.cand_c3_l3_ex2_read.name
  policy_arn = data.aws_iam_policy.AWSLambdaExecute.arn
}
resource "aws_iam_role_policy_attachment" "test-attach-4" {
  role       = aws_iam_role.cand_c3_l3_ex2_read.name
  policy_arn = data.aws_iam_policy.AmazonS3ReadOnlyAccess.arn
}
resource "aws_iam_role_policy_attachment" "test-attach-6" {
  role       = aws_iam_role.cand_c3_l3_ex2_read.name
  policy_arn = aws_iam_policy.decrypt_data_by_key.arn
}