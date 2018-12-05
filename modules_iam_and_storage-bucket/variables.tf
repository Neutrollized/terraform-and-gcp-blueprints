#-----------------------
# provider variables
#-----------------------
variable "project_id" {}

variable "credentials_file_path" {}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}

#------------------------
# Storage Bucket variables
#------------------------
variable "bucket_name" {}

variable "force_destroy" {
  description = "If false, bucket will not be deleted if it contains objects"
  default     = "true"
}
