// Configure the GCP provider
provider "google" {
  version     = "~> 1.19"
  project     = "${var.project_id}"
  credentials = "${file("${var.credentials_file_path}")}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}

provider "google-beta" {
  version     = "~> 1.19"
  project     = "${var.project_id}"
  credentials = "${file("${var.credentials_file_path}")}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}
