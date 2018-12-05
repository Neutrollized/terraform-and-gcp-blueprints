resource "google_service_account" "storage_object_admin" {
  account_id   = "storage-object-admin"
  display_name = "Storage Object Admin"
}

resource "google_service_account_key" "storage_object_admin_key" {
  service_account_id = "${google_service_account.storage_object_admin.name}"
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "google_storage_bucket_iam_binding" "my_bucket_storage_object_admin" {
  bucket = "${module.my_bucket.bucket_name}"
  role   = "roles/storage.objectAdmin"

  members = [
    "serviceAccount:${google_service_account.storage_object_admin.email}",
  ]
}

// random_string resource will create an extra string of characters
// to append to my bucket name to make it unique
resource random_string "default" {
  length = 8
  special = false
}

module "my_bucket" {
  // source = "git@github.com:dansible/terraform-google-storage-bucket.git?ref=v1.1.0"
  source  = "dansible/storage-bucket/google"
  version = "1.1.0"

  bucket_name        = "${lower(format("%s-%s", var.bucket_name, random_string.default.result))}"
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
  bucket  = "${module.my_bucket.bucket_name}"
}

// upload files
// unfortunately you can only upload to the root folder and not subfolders :(
resource "google_storage_bucket_object" "picture1" {
  name   = "dog.jpg"
  source = "./files/Domestication.jpg"
  bucket = "${module.my_bucket.bucket_name}"
}

resource "google_storage_bucket_object" "textfile1" {
  name    = "notes.txt"
  content = "random stuff..."
  bucket  = "${module.my_bucket.bucket_name}"
}
