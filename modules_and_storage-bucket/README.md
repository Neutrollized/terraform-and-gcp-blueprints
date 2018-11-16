# Modules & Storage Bucket

[Storage Bucket](https://www.terraform.io/docs/providers/google/r/storage_bucket.html)

[Storage Bucket Object](https://www.terraform.io/docs/providers/google/r/storage_bucket_object.html)


Often, a single resource on its own won't mean much unless you have others.  For example, if you want a good load balancing setup with auto-healing, you'll want resources like an instance group manager, instance template, firewall, forwarding rule, target pool, http health check, etc.  Now, what if you need to build just one and then never again...sure you can write TF code to build out those resources individually, but what happens if it's something you need to create regularly or multiples of?  You'll end up with really long TF blueprint.  

This is where Terraform [modules](https://www.terraform.io/docs/modules/usage.html) come in.  They are a good way to do repetitive tasks/build multiple resources in one "bulk resource builder".  This is the module I will be using to create a storage bucket and (optionaly) set ACLs, etc.: [Google Storage Bucket Module](https://registry.terraform.io/modules/dansible/storage-bucket/google/1.1.0)


```
var.bucket_name
  Enter a value: glensbucket

Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.google_client_config.current: Refreshing state...

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + google_storage_bucket_object.folders[0]
      id:                          <computed>
      bucket:                      "${module.bootstrap_bucket.bucket_name}"
      content:                     "config"
      content_type:                <computed>
      crc32c:                      <computed>
      detect_md5hash:              "different hash"
      md5hash:                     <computed>
      name:                        "config/"
      storage_class:               <computed>

  + google_storage_bucket_object.folders[1]
      id:                          <computed>
      bucket:                      "${module.bootstrap_bucket.bucket_name}"
      content:                     "license"
      content_type:                <computed>
      crc32c:                      <computed>
      detect_md5hash:              "different hash"
      md5hash:                     <computed>
      name:                        "license/"
      storage_class:               <computed>

  + google_storage_bucket_object.folders[2]
      id:                          <computed>
      bucket:                      "${module.bootstrap_bucket.bucket_name}"
      content:                     "software"
      content_type:                <computed>
      crc32c:                      <computed>
      detect_md5hash:              "different hash"
      md5hash:                     <computed>
      name:                        "software/"
      storage_class:               <computed>

  + google_storage_bucket_object.folders[3]
      id:                          <computed>
      bucket:                      "${module.bootstrap_bucket.bucket_name}"
      content:                     "content"
      content_type:                <computed>
      crc32c:                      <computed>
      detect_md5hash:              "different hash"
      md5hash:                     <computed>
      name:                        "content/"
      storage_class:               <computed>

  + google_storage_bucket_object.picture1
      id:                          <computed>
      bucket:                      "${module.bootstrap_bucket.bucket_name}"
      content_type:                <computed>
      crc32c:                      <computed>
      detect_md5hash:              "different hash"
      md5hash:                     <computed>
      name:                        "dog.jpg"
      source:                      "./files/Domestication.jpg"
      storage_class:               <computed>

  + google_storage_bucket_object.textfile1
      id:                          <computed>
      bucket:                      "${module.bootstrap_bucket.bucket_name}"
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

  + module.bootstrap_bucket.google_storage_bucket.bucket
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

  + module.bootstrap_bucket.google_storage_bucket_acl.bucket_acl
      id:                          <computed>
      bucket:                      "${google_storage_bucket.bucket.name}"
      default_acl:                 "projectPrivate"


Plan: 9 to add, 0 to change, 0 to destroy.
```
