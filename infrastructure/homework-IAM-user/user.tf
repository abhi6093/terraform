provider "aws" {
    region = "ap-northeast-3"
}

resource "aws_iam_user" "nu" {
  name = "new-user"
  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_s3_bucket" "CB" {
  bucket = "var.s3-bucket-name"
  tags = {
    Name        = "new-bucket"
    Environment = "Dev"
  }
}  

resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3_access_policy"
  description = "IAM policy for S3 bucket access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
        ],
        Resource = [
          aws_s3_bucket.CB.arn,
          "${aws_s3_bucket.CB.arn}/*",
        ],
      },
    ],
  })
}

resource "aws_iam_user_policy_attachment" "s3_access_attachment" {
  user       = aws_iam_user.nu.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

variable "s3-bucket-name" {
  default = "bucket-from-terraform"
}