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
#   pgp_key = "keybase:Aden"
  password_reset_required = true
  password_length = 12
}

output "password" {
  value = aws_iam_user_login_profile.example.encrypted_password
}