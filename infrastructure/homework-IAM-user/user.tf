provider "aws" {
    region "ap-northeast-3"
}

resource "aws_iam_user" "tf" {
    name = "terraform_user"

   tags = {
    tag-key = "tag-value" 
   }
}

resource "aws_iam_access_key"  "tf" {
    user = "aws_iam_user.tf.name"
}

resource "aws_s3_bucket" "practice" {
    bucket = "my-tf-practice-bucket"
    tags = {
        Name = "My-bucket-practice"
        Environment = "Dev"
    }
}

resource "aws_bucket_policy"  "to_access_above_bucket" {
    bucket = aws_s3_bucket.practice.id
    policy = data.aws_iam_policy_document.to_access_above_bucket    
}

data "aws_iam_policy_document" "to_access_above_bucket" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["123456789012"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.practice.arn,
      "${aws_s3_bucket.practice.arn}/*",
    ]
  }
}
