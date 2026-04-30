terraform {
  backend "s3" {
    bucket         = "tf-s3-backend-bucket-7nzr0pda"
    region         = "ap-southeast-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}