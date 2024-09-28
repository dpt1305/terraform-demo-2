data "aws_caller_identity" "current" {}

resource "aws_kms_key" "udacity_key" {
	description             = "An example multi-Region primary key"
	# multi_region            = true
	is_enabled 				= false
	# enable_key_rotation     = true
	deletion_window_in_days = 7
	# policy = jsonencode({
	# 	Version = "2012-10-17"
	# 	Id      = "cand-c3-l3-ex2-key"
	# 	Statement = [
	# 	{
	# 		Sid    = "Enable IAM User Permissions"
	# 		Effect = "Allow"
	# 		Principal = {
	# 			AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
	# 		},
	# 		Action   = "kms:*"
	# 		Resource = "*"
	# 	},
		# {
		# 	Sid    = "Allow administration of the key"
		# 	Effect = "Allow"
		# 	Principal = {
		# 	AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/Alice"
		# 	},
		# 	Action = [
		# 	"kms:ReplicateKey",
		# 	"kms:Create*",
		# 	"kms:Describe*",
		# 	"kms:Enable*",
		# 	"kms:List*",
		# 	"kms:Put*",
		# 	"kms:Update*",
		# 	"kms:Revoke*",
		# 	"kms:Disable*",
		# 	"kms:Get*",
		# 	"kms:Delete*",
		# 	"kms:ScheduleKeyDeletion",
		# 	"kms:CancelKeyDeletion"
		# 	],
		# 	Resource = "*"
		# },
		# {
		# 	Sid    = "Allow use of the key"
		# 	Effect = "Allow"
		# 	Principal = {
		# 	AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/Bob"
		# 	},
		# 	Action = [
		# 	"kms:DescribeKey",
		# 	"kms:Encrypt",
		# 	"kms:Decrypt",
		# 	"kms:ReEncrypt*",
		# 	"kms:GenerateDataKey",
		# 	"kms:GenerateDataKeyWithoutPlaintext"
		# 	],
		# 	Resource = "*"
		# }
		# ]
	# })
}

resource "aws_kms_alias" "a" {
	name          = "alias/cand-c3-l3-ex2-key"
	target_key_id = resource.aws_kms_key.udacity_key.key_id
}