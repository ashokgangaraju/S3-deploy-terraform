#resource "aws_kms_key" "mykey" {
  #description             = "This key is used to encrypt bucket objects"
  #deletion_window_in_days = 10
#}

resource "aws_s3_bucket" "onebucket" {
   bucket = "testing-s3-with-terraform-ashok"
   #acl = "private"
   #versioning {
      #enabled = true
      
    tags = {
     Name = "Bucket1"
     Environment = "Test"
   }  
}
resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.onebucket.id
  acl    = "private"
}   
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.onebucket.id
  versioning_configuration {
    status = "Enabled"
  }
}   

#Enable encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.onebucket.id

  rule {
    #apply_server_side_encryption_by_default {
      bucket_key_enabled = true
      #default = "aws/s3"
    }
  }
#}

# Block S3 public access
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.onebucket.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}