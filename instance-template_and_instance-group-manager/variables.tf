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

#------------------------------
# instance template variables
#------------------------------
variable "machine_type" {
  description = "GCP Machine Types: https://cloud.google.com/compute/docs/machine-types"
  default     = "f1-micro"
}

variable "image_project" {
  description = "GCP Images: https://cloud.google.com/compute/docs/images"
  default     = "ubuntu-os-cloud"
}

variable "image_family" {
  description = "GCP Images: https://cloud.google.com/compute/docs/images"
  default     = "ubuntu-minimal-1804-lts"
}

variable "public_key" {
  default = "glen:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDX6CRSh9aZdC5fiK+WmXpB269ZN/gRYp0EXWZxucaE/W10hk+iVM1z0d5sDQSHcJ9CL7zIUTPS7Q3vf/RFwoK+EmboW2JV1B4QnCSpeboD+hHGygtqoznNTHqhI09v8/O8woYd1Uzuvhv9rdyI8S/puY+DDTyjBi3T5CeACdtdpgvtp700pwigvUS6lbjE9ocJRZHT+J7V30Fc01E6uwwFZEurBBNiotTpEcYyxa8je49y0MAumxeHgxujGatOcXN/3QGNq4FiO8it46jDLhSHPJzYwIZ/v+hLokL9WCAbU5YlFSeUhsm31RPvr3lkzADQYYkIvtXKEay9NEZ3eZxp glen"
}
