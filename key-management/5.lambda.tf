variable "lambda_runtime" {
	type = string
	default = "python3.12"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "./lambda-func/function.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = "udacity_lambda_function_name"
  role          = resource.aws_iam_role.cand_c3_l3_ex2_write.arn
  handler       = "function.handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = var.lambda_runtime

  layers = [aws_lambda_layer_version.lambda_layer.arn]

  environment {
    variables = {
      foo = "bar"
    }
  }
}

data "archive_file" "layer_zip" {
  type = "zip"
  source_dir = "./python"
  output_path = "layer.zip"
}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "layer.zip"
  layer_name = "udacity_python_lambda_layer"
  compatible_runtimes = [var.lambda_runtime]
}