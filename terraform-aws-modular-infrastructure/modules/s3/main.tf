resource "aws_s3_bucket" "bucket" {
  bucket = "${var.name}-module-infrastructure-bucket"
  acl    = var.acl

  versioning {
    enabled = var.versioning
  }

  tags = merge(
    var.tags,
    { Name = "${var.name}-bucket" }
  )
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
