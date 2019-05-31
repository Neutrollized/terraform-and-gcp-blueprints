// PROJECT Variables
variable "bucket_name" {
  default = "pa-bootstrap"
}

variable "force_destroy" {
  description = "If false, bucket will not be deleted if it contains objects"
  default     = "true"
}

variable "environment" {
  default = "test"
}

variable "region" {
  default = "us-central1"
}

variable "region_zone" {
  default = "us-central1-c"
}

variable "project_id" {}

variable "credentials_file_path" {}

variable "zone" {
  default = "us-central1-c"
}

variable "zone_2" {
  default = "us-central1-a"
}

variable "public_key" {
  default = "admin:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDX6CRSh9aZdC5fiK+WmXpB269ZN/gRYp0EXWZxucaE/W10hk+iVM1z0d5sDQSHcJ9CL7zIUTPS7Q3vf/RFwoK+EmboW2JV1B4QnCSpeboD+hHGygtqoznNTHqhI09v8/O8woYd1Uzuvhv9rdyI8S/puY+DDTyjBi3T5CeACdtdpgvtp700pwigvUS6lbjE9ocJRZHT+J7V30Fc01E6uwwFZEurBBNiotTpEcYyxa8je49y0MAumxeHgxujGatOcXN/3QGNq4FiO8it46jDLhSHPJzYwIZ/v+hLokL9WCAbU5YlFSeUhsm31RPvr3lkzADQYYkIvtXKEay9NEZ3eZxp admin"
}

// FIREWALL Variables
variable "firewall_name" {
  default = "pan-vm"
}

variable "firewall_count" {
  default = 1
}

variable "image_fw" {
  # default = "Your_VM_Series_Image"

  # /Cloud Launcher API Calls to images/
  default = "https://www.googleapis.com/compute/v1/projects/paloaltonetworksgcp-public/global/images/vmseries-byol-810"

  # default = "https://www.googleapis.com/compute/v1/projects/paloaltonetworksgcp-public/global/images/vmseries-bundle2-810"
  # default = "https://www.googleapis.com/compute/v1/projects/paloaltonetworksgcp-public/global/images/vmseries-bundle1-810"
}

variable "machine_type_fw" {
  default = "n1-standard-4"
}

variable "machine_cpu_fw" {
  default = "Intel Skylake"
}

// This is the typical order of interfaces: management, untrust (public), trust (private)
// but if you want to put an ELB in front, the ELB load balances to interface_0
// hence the swap between management and untrst interfaces
variable "interface_0_name" {
  default = "management"
}

variable "interface_1_name" {
  default = "untrust"
}

variable "interface_2_name" {
  default = "trust"
}

variable "scopes_fw" {
  default = ["https://www.googleapis.com/auth/cloud.useraccounts.readonly",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
  ]
}

// WEB-SERVER Vaiables
variable "web_server_name" {
  default = "webserver"
}

variable "machine_type_web" {
  default = "f1-micro"
}

variable "image_web" {
  default = "debian-9"
}

variable "scopes_web" {
  default = ["https://www.googleapis.com/auth/cloud.useraccounts.readonly",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/compute.readonly",
  ]
}

##################

