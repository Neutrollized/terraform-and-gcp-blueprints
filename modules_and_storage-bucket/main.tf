// random_id resource will create an extra string of characters to append to my bucket name
// to make it unique
resource random_id "default" {
  byte_length = 6
}

module "bootstrap_bucket" {
  // source = "git@github.com:dansible/terraform-google-storage-bucket.git?ref=v1.1.0"
  source  = "dansible/storage-bucket/google"
  version = "1.1.0"

  bucket_name        = "${lower(format("%s-%s", var.bucket_name, random_id.default.b64_url))}"
  project            = "${var.project_id}"
  location           = "${var.region}"
  storage_class      = "REGIONAL"
  default_acl        = "projectPrivate"
  force_destroy      = "true"
  logging_enabled    = false
  versioning_enabled = true
}

// create folders under storage bucket
locals {
  folders = ["config", "license", "software", "content"]
}

resource "google_storage_bucket_object" "folders" {
  count   = "${length(local.folders)}"
  name    = "${local.folders[count.index]}/"
  content = "${local.folders[count.index]}"
  bucket  = "${module.bootstrap_bucket.bucket_name}"
}

// upload files
// unfortunately you can only upload to the root folder and not subfolders :(
resource "google_storage_bucket_object" "picture1" {
  name   = "dog.jpg"
  source = "./files/Domestication.jpg"
  bucket = "${module.bootstrap_bucket.bucket_name}"
}

resource "google_storage_bucket_object" "textfile1" {
  name    = "notes.txt"
  content = "random stuff..."
  bucket  = "${module.bootstrap_bucket.bucket_name}"
}
