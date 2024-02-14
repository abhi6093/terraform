provider "aws" {
    region = "ap-northeast-3"
}
resource "aws_iam_user" "lb" {
    name = "terraform_user"
    tags = {
    tag-key = "tag-value" 
   }
}

resource "aws_iam_access_key"  "lb" {
    user = "aws_iam_user.lb.name"
}

resource "aws_s3_bucket" "practice" {
    bucket = "my-lb-practice-bucket"
    tags = {
        Name = "My-bucket-practice"
        Environment = "Dev"
    }
}