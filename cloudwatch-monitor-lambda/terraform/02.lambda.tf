
variable "layer_name" {
  type = string
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "udacity_iam_for_lambda" {
  name               = "udacity_iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "../node_app/function.js"
  output_path = "lambda_function_payload.zip"
}


data "aws_lambda_layer_version" "existing" {
  layer_name = var.layer_name
}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "layer.zip"
  layer_name = "udacity_lambda_layer"

  compatible_runtimes = ["nodejs20.x"]
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = "udacity_lambda_function_name"
  role          = aws_iam_role.udacity_iam_for_lambda.arn
  handler       = "function.handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "nodejs20.x"

  layers = [aws_lambda_layer_version.lambda_layer.arn]

  environment {
    variables = {
      foo = "bar"
    }
  }
}