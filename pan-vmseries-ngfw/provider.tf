// Configure the GCP provider
provider "google" {
  region      = "${var.region}"
  project     = "${var.project_id}"
  credentials = "${file("${var.credentials_file_path}")}"
  zone        = "${var.region_zone}"
}
