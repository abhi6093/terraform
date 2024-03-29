provider "aws"  {
    region = "ap-northeast-3"
}
#vpc
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "main"
  }
}
#subnets
resource "aws_subnet" "subnet_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "subnet-1"
    }
} 

resource "aws_subnet" "subnet_2" {
 vpc_id = aws_vpc.main.id
 cidr_block = "10.0.1.0/24"
 tags = {
    Name = "subnet-2"
 }
}
#iam role
 resource "aws_iam_role" "eks_role" {
  name = "eks_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "for-eks-role"
  }
} 
#iam policy attachment
resource "aws_iam_role_policy_attachment" "eks_cluster" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_role.name
}

resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_role.name
}
#cluster
resource "aws_eks_cluster" "new_cluster" {
    name = "new_cluster"
    role_arn = aws_iam_role.eks_role.arn

vpc_config {
    subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
}
}