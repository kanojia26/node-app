resource "aws_s3_bucket" "abhi-syok" {
  bucket = "abhi-terraform-syok"
  
  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
