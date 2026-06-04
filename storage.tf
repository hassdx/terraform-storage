resource "aws_s3_bucket" "bucket" {
  bucket = "cmtr-3v98t79h-bucket-1780598335"

  tags = {
    Project = "cmtr-3v98t79h"
  }
}