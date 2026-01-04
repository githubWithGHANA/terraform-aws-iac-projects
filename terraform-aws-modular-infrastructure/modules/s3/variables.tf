variable "name" {
  description = "Name prefix for S3 bucket"
  type        = string
}

variable "versioning" {
  description = "Enable versioning on the bucket"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags for the bucket"
  type        = map(string)
  default     = {}
}

variable "acl" {
  description = "Bucket ACL"
  type        = string
  default     = "private"
}
