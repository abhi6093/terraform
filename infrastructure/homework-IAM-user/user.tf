[11:18 PM, 2/14/2024] Sahil BCA College: provider "aws" {
    region = "ap-south-1"
}

resource "aws_iam_user" "lb" {
  name = "loadbalancer"
  path = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_s3_bucket" "A" {
  bucket = "var.s3-bucket-name"
  tags = {
    Name        = "My bucket"
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
          aws_s3_bucket.A.arn,
          "${aws_s3_bucket.A.arn}/*",
        ],
      },
    ],
  })
}

resource "aws_iam_user_policy_attachment" "s3_access_attachment" {
  user       = aws_iam_user.lb.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}
 variable "s3-bucket-name" {
  type    = string
  default = "my-tf-test-bucket0707"
}