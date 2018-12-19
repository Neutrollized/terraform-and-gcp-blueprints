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
# Filestore variables
#------------------------
variable "filestore_tier" {
  description = "service tier: standard or premium"
  default     = "STANDARD"
}

variable "filestore_sharename" {}

#-----------------------------
# Compute Engine variables
#-----------------------------
variable "image_project" {
  default = "centos-cloud"
}

variable "image_family" {
  default = "centos-7"
}

variable "machine_type" {
  default = "f1-micro"
}

variable "tags" {
  type    = "list"
  default = ["nfs"]
}

variable "ssh_user" {}
variable "private_key_file_path" {}

variable "public_key_file_path" {
  description = "public key of ssh_user - can be string or as a file depending on how you want to provide it"

  // default = "glen:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDX6CRSh9aZdC5fiK+WmXpB269ZN/gRYp0EXWZxucaE/W10hk+iVM1z0d5sDQSHcJ9CL7zIUTPS7Q3vf/RFwoK+EmboW2JV1B4QnCSpeboD+hHGygtqoznNTHqhI09v8/O8woYd1Uzuvhv9rdyI8S/puY+DDTyjBi3T5CeACdtdpgvtp700pwigvUS6lbjE9ocJRZHT+J7V30Fc01E6uwwFZEurBBNiotTpEcYyxa8je49y0MAumxeHgxujGatOcXN/3QGNq4FiO8it46jDLhSHPJzYwIZ/v+hLokL9WCAbU5YlFSeUhsm31RPvr3lkzADQYYkIvtXKEay9NEZ3eZxp glen"
}

variable "nfs_mnt_pt" {
  description = "NFS mount location on client"
  default     = "/mnt/test"
}
