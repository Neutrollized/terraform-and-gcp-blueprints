# Modules, IAM & Storage Bucket

[Google Service Account](https://www.terraform.io/docs/providers/google/r/google_service_account.html)

[Google Service Account Key](https://www.terraform.io/docs/providers/google/r/google_service_account_key.html)

[Storage Bucket IAM](https://www.terraform.io/docs/providers/google/r/storage_bucket_iam.html)

[Storage Bucket](https://www.terraform.io/docs/providers/google/r/storage_bucket.html)

[Storage Bucket Object](https://www.terraform.io/docs/providers/google/r/storage_bucket_object.html)


Often, a single resource on its own won't mean much unless you have others.  For example, if you want a good load balancing setup with auto-healing, you'll want resources like an instance group manager, instance template, firewall, forwarding rule, target pool, http health check, etc.  Now, what if you need to build just one and then never again...sure you can write TF code to build out those resources individually, but what happens if it's something you need to create regularly or multiples of?  You'll end up with really long TF blueprint.  

This is where Terraform [modules](https://www.terraform.io/docs/modules/usage.html) come in.  They are a good way to do repetitive tasks/build multiple resources in one "bulk resource builder".  This is the module I will be using to create a storage bucket and (optionaly) set ACLs, etc.: [Google Storage Bucket Module](https://registry.terraform.io/modules/dansible/storage-bucket/google/1.1.0)

We'll also be touching on IAM here as we'll be creating a service account (along with the private and public keys you'll need to connect) and assigning it one of the many [IAM Roles for Cloud Storage](https://cloud.google.com/storage/docs/access-control/iam-roles)


```
var.bucket_name
  Enter a value: mybucket

Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.google_client_config.current: Refreshing state...

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + google_service_account.storage_object_admin
      id:                          <computed>
      account_id:                  "storage-object-admin"
      display_name:                "Storage Object Admin"
      email:                       <computed>
      name:                        <computed>
      project:                     <computed>
      unique_id:                   <computed>

  + google_service_account_key.storage_object_admin_key
      id:                          <computed>
      key_algorithm:               "KEY_ALG_RSA_2048"
      name:                        <computed>
      private_key:                 <computed>
      private_key_encrypted:       <computed>
      private_key_fingerprint:     <computed>
      private_key_type:            "TYPE_GOOGLE_CREDENTIALS_FILE"
      public_key:                  <computed>
      public_key_type:             "TYPE_X509_PEM_FILE"
      service_account_id:          "${google_service_account.storage_object_admin.name}"
      valid_after:                 <computed>
      valid_before:                <computed>

  + google_storage_bucket_iam_binding.my_bucket_storage_object_admin
      id:                          <computed>
      bucket:                      "${module.my_bucket.bucket_name}"
      etag:                        <computed>
      members.#:                   <computed>
      role:                        "roles/storage.objectAdmin"

  + google_storage_bucket_object.folders[0]
      id:                          <computed>
      bucket:                      "${module.my_bucket.bucket_name}"
      content:                     "config"
      content_type:                <computed>
      crc32c:                      <computed>
      detect_md5hash:              "different hash"
      md5hash:                     <computed>
      name:                        "config/"
      storage_class:               <computed>

  + google_storage_bucket_object.folders[1]
      id:                          <computed>
      bucket:                      "${module.my_bucket.bucket_name}"
      content:                     "license"
      content_type:                <computed>
      crc32c:                      <computed>
      detect_md5hash:              "different hash"
      md5hash:                     <computed>
      name:                        "license/"
      storage_class:               <computed>

  + google_storage_bucket_object.folders[2]
      id:                          <computed>
      bucket:                      "${module.my_bucket.bucket_name}"
      content:                     "software"
      content_type:                <computed>
      crc32c:                      <computed>
      detect_md5hash:              "different hash"
      md5hash:                     <computed>
      name:                        "software/"
      storage_class:               <computed>

  + google_storage_bucket_object.folders[3]
      id:                          <computed>
      bucket:                      "${module.my_bucket.bucket_name}"
      content:                     "content"
      content_type:                <computed>
      crc32c:                      <computed>
      detect_md5hash:              "different hash"
      md5hash:                     <computed>
      name:                        "content/"
      storage_class:               <computed>

  + google_storage_bucket_object.picture1
      id:                          <computed>
      bucket:                      "${module.my_bucket.bucket_name}"
      content_type:                <computed>
      crc32c:                      <computed>
      detect_md5hash:              "different hash"
      md5hash:                     <computed>
      name:                        "dog.jpg"
      source:                      "./files/Domestication.jpg"
      storage_class:               <computed>

  + google_storage_bucket_object.textfile1
      id:                          <computed>
      bucket:                      "${module.my_bucket.bucket_name}"
      content:                     "random stuff..."
      content_type:                <computed>
      crc32c:                      <computed>
      detect_md5hash:              "different hash"
      md5hash:                     <computed>
      name:                        "notes.txt"
      storage_class:               <computed>

  + random_id.default
      id:                          <computed>
      b64:                         <computed>
      b64_std:                     <computed>
      b64_url:                     <computed>
      byte_length:                 "6"
      dec:                         <computed>
      hex:                         <computed>

  + module.my_bucket.google_storage_bucket.bucket
      id:                          <computed>
      force_destroy:               "true"
      labels.%:                    "1"
      labels.managed-by:           "terraform"
      location:                    "US-CENTRAL1"
      logging.#:                   "1"
      logging.0.log_bucket:        "${local.log_bucket_name}"
      logging.0.log_object_prefix: <computed>
      name:                        "${var.bucket_name}"
      project:                     "zoey-215712"
      self_link:                   <computed>
      storage_class:               "REGIONAL"
      url:                         <computed>
      versioning.#:                "1"
      versioning.0.enabled:        "true"

  + module.my_bucket.google_storage_bucket_acl.bucket_acl
      id:                          <computed>
      bucket:                      "${google_storage_bucket.bucket.name}"
      default_acl:                 "projectPrivate"


Plan: 12 to add, 0 to change, 0 to destroy.
```
