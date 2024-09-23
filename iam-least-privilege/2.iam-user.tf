variable "user_name" {
    default = "cand-c3-iam-user"
    type = string
}

resource "aws_iam_user" "udacity_iam_usr" {
    name = var.user_name
    path = "/dev/"
    force_destroy = true
    tags = {
        Name = "udacity"
    }
}

resource "aws_iam_user_login_profile" "example" {
    user    = aws_iam_user.udacity_iam_usr.name
    # pgp_key = "keybase:${var.user_name}"
    password_reset_required = false
    password_length = 12
}

output "password" {
  	value = aws_iam_user_login_profile.example.encrypted_password
}