provider "aws" {
    region = "ap-northeast-3"
}
resource "aws_iam_user" "new_user" {
    name = "new-user"
    tags = {
        Name = "New-User"
    }
}
resource "aws_s3_bucket" "new_bucket" {
  bucket = "terraform-bucket"
  tags = {
    Name        = "New-Bucket"
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
        Action   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"],
        Resource = [aws_s3_bucket.new_bucket.arn, "${aws_s3_bucket.new_bucket.arn}/*"],
      },
    ],
  })
}

resource "aws_iam_user_policy_attachment" "s3_access_attachment" {
  user       = aws_iam_user.new_user.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}