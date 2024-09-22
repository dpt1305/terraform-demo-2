
# ------------ Variables
variable "role_name" {
    type = string
    default = "cand-c3-iam-role"
}
variable "policy_name" {
    type = string
    default = "cand-c3-iam-user-policy"
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
                    AWS = "${resource.aws_iam_user.udacity_iam_usr.arn}",
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
                Action = [
                    "sts:AssumeRole",
                ]
                Effect   = "Allow"
                Resource = "${aws_iam_role.udacity_test_role.arn}"
            },
        ]
    })
    
}
data "aws_iam_policy" "example" {
    name = "AmazonS3ReadOnlyAccess"
}

# ----------- Attach policies to role
resource "aws_iam_role_policy_attachment" "attach_1" {
    role       = aws_iam_role.udacity_test_role.name
    policy_arn = aws_iam_policy.policy.arn
}
resource "aws_iam_role_policy_attachment" "attach_2" {
    role       = aws_iam_role.udacity_test_role.name
    policy_arn = data.aws_iam_policy.example.arn
}
