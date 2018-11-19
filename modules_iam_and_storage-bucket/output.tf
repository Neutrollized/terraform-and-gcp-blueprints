output "my_bucket_name" {
  value = "${module.my_bucket.bucket_name}"
}

// keys are base64 encoded, so you'll need to run base64decode if you want to see anything useful
// you can obtain the service account email from the private key output as well
output "storage_object_admin_private_key" {
  value = "${base64decode(google_service_account_key.storage_object_admin_key.private_key)}"
}

output "storage_object_admin_public_key" {
  value = "${base64decode(google_service_account_key.storage_object_admin_key.public_key)}"
}
