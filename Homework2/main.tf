provider "aws" {
  region = "us-east-2"
}

resource "aws_key_pair" "Bastion-key" {
  key_name   = "Bastion-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_s3_bucket" "bucket1" {
  bucket = "kaizen-kluivert1"
}

resource "aws_s3_bucket" "bucket2" {
  bucket = "kaizen-mega"
  force_destroy = true
}

resource "aws_s3_bucket" "bucket3" {
  bucket_prefix = "kaizen-"
  force_destroy = true
}

resource "aws_s3_bucket" "emperork" { 
    bucket = "emperork" 
    }

resource "aws_s3_bucket" "emprork1" { 
    bucket = "emprork1" 
    }

# terraform import aws_s3_bucket.emperork emperork
# terraform import aws_s3_bucket.emprork1 emprork1

resource "aws_iam_user" "lb" {
  for_each = toset(["jenny","rose","lisa","jisoo"])
  name = each.key
}

resource "aws_iam_group" "blackpink" {
  name = "blackpinks"
}

resource "aws_iam_group_membership" "blackpink" {
  name = "tf-testing-group-membership"

  users = [
    for i in aws_iam_user.lb : i.name
  ]

  group = aws_iam_group.blackpink.name
}
