data "archive_file" "read_lambda" {
    type        = "zip"
    source_file = "./lambda-func/function_read.py"
    output_path = "lambda_read_function_payload.zip"
}

resource "aws_lambda_function" "read_lambda" {
    # If the file is not in the current working directory you will need to include a
    # path.module in the filename.
    filename      = "lambda_read_function_payload.zip"
    function_name = "udacity_lambda_read_s3"
    role          = resource.aws_iam_role.cand_c3_l3_ex2_read.arn
    handler       = "function_read.handler"

    source_code_hash = data.archive_file.read_lambda.output_base64sha256

    runtime = var.lambda_runtime

    layers = [aws_lambda_layer_version.lambda_layer.arn]

    environment {
        variables = {
        foo = "bar"
        }
    }
}