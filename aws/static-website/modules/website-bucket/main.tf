resource "random_string" "random" {
  length = 16
  special = false
  upper = false
}
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.bucket_name}-${random_string.random.result}"
  force_destroy = true
}
resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.allow_public_access.json
  depends_on = [aws_s3_bucket_public_access_block.s3_allow_access] 
} 
 
data "aws_iam_policy_document" "allow_public_access" { 
 statement {  
   principals { 
        type = "AWS" 
        identifiers = ["*"] 
 } 
 
 actions = [ "s3:GetObject" ] 
 
 resources = [ aws_s3_bucket.s3_bucket.arn, "${aws_s3_bucket.s3_bucket.arn}/*" ] 
} 
} 
 
resource "aws_s3_bucket_website_configuration" "s3_bucket_config" { 
 bucket = aws_s3_bucket.s3_bucket.id 
  
 index_document { 
    suffix = var.home_page  
 } 
 
 error_document {  
    key = var.error_page 
 } 
} 
 
 
resource "aws_s3_bucket_public_access_block" "s3_allow_access" { 
 bucket = aws_s3_bucket.s3_bucket.id 
  
 block_public_acls = false 
 block_public_policy = false 
 ignore_public_acls = false 
 restrict_public_buckets = false  
} 
