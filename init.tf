terraform {
  backend "s3" {
    bucket = "devopsstfile"
    key    = "devops/demo/ec2/terraform.tfstate"
    region = "us-east-1"
    acl = "bucket-owner-full-control"
  }
}
