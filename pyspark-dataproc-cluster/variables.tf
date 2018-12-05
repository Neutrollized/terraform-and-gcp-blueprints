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

#--------------------------
# Storage Bucket variables
#--------------------------
variable "bucket_name" {}

variable "force_destroy" {
  description = "If false, bucket will not be deleted if it contains objects"
  default     = "false"
}

#-----------------------------
# Dataproc cluster variables
#-----------------------------
variable "machine_type" {
  default = "n1-standard-1"
}

variable "boot_disk_size_gb" {
  description = "Size of primary disk attached to each node; if not specified, GCP will currently set to 500GB"
  default     = 15
}

variable "num_masters" {
  description = "Number of master nodes in the cluster"
  default     = 1
}

variable "num_workers" {
  description = "Number of worker nodes in the cluster"
  default     = 2
}

variable "num_preemptible_workers" {
  description = "Number of preemptible worker nodes in the cluster"
  default     = 0
}

variable "sw_image_version" {
  description = "https://cloud.google.com/dataproc/docs/concepts/versioning/dataproc-versions"
  default     = "1.3.16-deb9"
}

variable "init_actions_bucket" {
  description = "https://github.com/GoogleCloudPlatform/dataproc-initialization-actions"
  default     = "dataproc-initialization-actions"
}

variable "init_actions_repo" {
  default = "jupyter"
}
