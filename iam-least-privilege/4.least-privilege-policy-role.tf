
# ------------ Variables
variable "role_name" {
    type = string
    default = "cand-c3-iam-role"
}
variable "policy_name" {
    type = string
    default = "cand-c3-iam-policy-least-priv"
}

# ---------------- Roles
resource "aws_iam_role" "udacity_test_role" {
    name = var.role_name
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Sid    = ""
                Principal = {
                    AWS = "081322589116"
                }
            },
        ]
    })
    force_detach_policies = true
    tags = {
        Name = var.role_name
    }
}

#-------------- Plocies
resource "aws_iam_policy" "policy" {
    name        = var.policy_name
    description = "Udacity policy"
    policy      = jsonencode({ 
        Version = "2012-10-17"
        Statement = [
            {
                Sid     = "ConsoleAccess"
                Effect   = "Allow"
                Action = [
                    "s3:GetAccountPublicAccessBlock",
                    "s3:GetBucketAcl",
                    "s3:GetBucketLocation",
                    "s3:GetBucketPollicyStatus",
                    "s3:GetBucketPublicAccessBlock",
                    "s3:ListAllMyBuckets",
                ]
                Resource = "*"
            },
            {
                Sid      = "ListObjectsInBucket"
                Effect   = "Allow"
                Action   = "s3:ListBucket"
                Resource = [
                    "arn:aws:s3:::${resource.aws_s3_bucket.main_bucket.id}"
                ]
            },
            
        ]
    })
}

# ----------- Attach policies to role
resource "aws_iam_role_policy_attachment" "attach_1" {
    role       = aws_iam_role.udacity_test_role.name
    policy_arn = aws_iam_policy.policy.arn
}
resource "aws_iam_policy_attachment" "attach_policy_to_user" {
    name = "udacity_policy_attachment"
    policy_arn = aws_iam_policy.policy.arn
    users = [ aws_iam_user.udacity_iam_usr.name ]
}