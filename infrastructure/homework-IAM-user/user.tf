provider  "aws"  {
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