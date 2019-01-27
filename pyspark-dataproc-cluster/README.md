# PySpark Dataproc Cluster

[Google Dataproc Cluster](https://www.terraform.io/docs/providers/google/r/dataproc_cluster.html)

[GCP Dataproc Initialization Actions](https://github.com/GoogleCloudPlatform/dataproc-initialization-actions)


Create a VPC in which a PySpark [Dataproc](https://cloud.google.com/dataproc/) cluster will be created.  We will once again use the [Google Storage Bucket Module](https://registry.terraform.io/modules/dansible/storage-bucket/google/1.1.0) to create the Dataproc Staging bucket.  The cluster will be provisioned and then initialized using one of the myriad of [Initialization Actions](https://cloud.google.com/dataproc/docs/concepts/configuring-clusters/init-actions) avaiable on GCP's GitHub repo (as well as their Storage Bucket).


## Note

The Dataproc clusters/instances are stateless, and as long as you don't destroy your Dataproc staging bucket, your work will be saved there and you shouldn't lose any work (hence `force_destroy` is set to `"false"` -- bucket will not be destroyed if it contains objects)


```
var.bucket_name
  Enter a value: dp-staging

Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.google_client_config.current: Refreshing state...

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + google_compute_firewall.my_dataproc_firewall_internal
      id:                                                                                          <computed>
      allow.#:                                                                                     "3"
      allow.1367131964.ports.#:                                                                    "0"
      allow.1367131964.protocol:                                                                   "icmp"
      allow.1486604749.ports.#:                                                                    "0"
      allow.1486604749.protocol:                                                                   "udp"
      allow.3848845357.ports.#:                                                                    "0"
      allow.3848845357.protocol:                                                                   "tcp"
      creation_timestamp:                                                                          <computed>
      destination_ranges.#:                                                                        <computed>
      direction:                                                                                   <computed>
      name:                                                                                        "dataproc-network-allow-internal"
      network:                                                                                     "dataproc-network"
      priority:                                                                                    "1000"
      project:                                                                                     <computed>
      self_link:                                                                                   <computed>
      source_ranges.#:                                                                             "1"
      source_ranges.684234266:                                                                     "192.168.30.0/24"

  + google_compute_firewall.my_dataproc_firewall_ssh
      id:                                                                                          <computed>
      allow.#:                                                                                     "1"
      allow.803338340.ports.#:                                                                     "1"
      allow.803338340.ports.0:                                                                     "22"
      allow.803338340.protocol:                                                                    "tcp"
      creation_timestamp:                                                                          <computed>
      destination_ranges.#:                                                                        <computed>
      direction:                                                                                   <computed>
      name:                                                                                        "dataproc-network-allow-ssh"
      network:                                                                                     "dataproc-network"
      priority:                                                                                    "1000"
      project:                                                                                     <computed>
      self_link:                                                                                   <computed>
      source_ranges.#:                                                                             "1"
      source_ranges.1080289494:                                                                    "0.0.0.0/0"

  + google_compute_network.my_dataproc_network
      id:                                                                                          <computed>
      auto_create_subnetworks:                                                                     "false"
      gateway_ipv4:                                                                                <computed>
      name:                                                                                        "dataproc-network"
      project:                                                                                     <computed>
      routing_mode:                                                                                <computed>
      self_link:                                                                                   <computed>

  + google_compute_subnetwork.my_dataproc_subnetwork
      id:                                                                                          <computed>
      creation_timestamp:                                                                          <computed>
      fingerprint:                                                                                 <computed>
      gateway_address:                                                                             <computed>
      ip_cidr_range:                                                                               "192.168.30.0/24"
      name:                                                                                        "dataproc-subnetwork"
      network:                                                                                     "${google_compute_network.my_dataproc_network.self_link}"
      project:                                                                                     <computed>
      region:                                                                                      "us-central1"
      secondary_ip_range.#:                                                                        <computed>
      self_link:                                                                                   <computed>

  + google_dataproc_cluster.my_pyspark_cluster
      id:                                                                                          <computed>
      cluster_config.#:                                                                            "1"
      cluster_config.0.bucket:                                                                     <computed>
      cluster_config.0.delete_autogen_bucket:                                                      "false"
      cluster_config.0.gce_cluster_config.#:                                                       "1"
      cluster_config.0.gce_cluster_config.0.internal_ip_only:                                      "false"
      cluster_config.0.gce_cluster_config.0.service_account_scopes.#:                              <computed>
      cluster_config.0.gce_cluster_config.0.subnetwork:                                            "dataproc-subnetwork"
      cluster_config.0.gce_cluster_config.0.zone:                                                  "us-central1-c"
      cluster_config.0.initialization_action.#:                                                    "1"
      cluster_config.0.initialization_action.0.script:                                             "gs://dataproc-initialization-actions/jupyter/jupyter.sh"
      cluster_config.0.initialization_action.0.timeout_sec:                                        "500"
      cluster_config.0.master_config.#:                                                            "1"
      cluster_config.0.master_config.0.disk_config.#:                                              "1"
      cluster_config.0.master_config.0.disk_config.0.boot_disk_size_gb:                            "15"
      cluster_config.0.master_config.0.disk_config.0.boot_disk_type:                               "pd-ssd"
      cluster_config.0.master_config.0.disk_config.0.num_local_ssds:                               <computed>
      cluster_config.0.master_config.0.instance_names.#:                                           <computed>
      cluster_config.0.master_config.0.machine_type:                                               "n1-standard-1"
      cluster_config.0.master_config.0.num_instances:                                              "1"
      cluster_config.0.preemptible_worker_config.#:                                                "1"
      cluster_config.0.preemptible_worker_config.0.disk_config.#:                                  <computed>
      cluster_config.0.preemptible_worker_config.0.instance_names.#:                               <computed>
      cluster_config.0.preemptible_worker_config.0.num_instances:                                  "0"
      cluster_config.0.software_config.#:                                                          "1"
      cluster_config.0.software_config.0.image_version:                                            "1.3.16-deb9"
      cluster_config.0.software_config.0.override_properties.%:                                    "1"
      cluster_config.0.software_config.0.override_properties.dataproc:dataproc.allow.zero.workers: "true"
      cluster_config.0.software_config.0.properties.%:                                             <computed>
      cluster_config.0.staging_bucket:                                                             "${module.my_dataproc_staging_bucket.bucket_name}"
      cluster_config.0.worker_config.#:                                                            "1"
      cluster_config.0.worker_config.0.disk_config.#:                                              "1"
      cluster_config.0.worker_config.0.disk_config.0.boot_disk_size_gb:                            "15"
      cluster_config.0.worker_config.0.disk_config.0.boot_disk_type:                               "pd-standard"
      cluster_config.0.worker_config.0.disk_config.0.num_local_ssds:                               "1"
      cluster_config.0.worker_config.0.instance_names.#:                                           <computed>
      cluster_config.0.worker_config.0.machine_type:                                               "n1-standard-1"
      cluster_config.0.worker_config.0.num_instances:                                              "2"
      labels.%:                                                                                    <computed>
      name:                                                                                        "pyspark-cluster"
      project:                                                                                     <computed>
      region:                                                                                      "us-central1"

  + random_string.default
      id:                                                                                          <computed>
      length:                                                                                      "8"
      lower:                                                                                       "true"
      min_lower:                                                                                   "0"
      min_numeric:                                                                                 "0"
      min_special:                                                                                 "0"
      min_upper:                                                                                   "0"
      number:                                                                                      "true"
      result:                                                                                      <computed>
      special:                                                                                     "false"
      upper:                                                                                       "true"

  + module.my_dataproc_staging_bucket.google_storage_bucket.bucket
      id:                                                                                          <computed>
      force_destroy:                                                                               "false"
      labels.%:                                                                                    "1"
      labels.managed-by:                                                                           "terraform"
      location:                                                                                    "US-CENTRAL1"
      logging.#:                                                                                   "1"
      logging.0.log_bucket:                                                                        "${local.log_bucket_name}"
      logging.0.log_object_prefix:                                                                 <computed>
      name:                                                                                        "${var.bucket_name}"
      project:                                                                                     "zoey-215712"
      self_link:                                                                                   <computed>
      storage_class:                                                                               "REGIONAL"
      url:                                                                                         <computed>
      versioning.#:                                                                                "1"
      versioning.0.enabled:                                                                        "true"

  + module.my_dataproc_staging_bucket.google_storage_bucket_acl.bucket_acl
      id:                                                                                          <computed>
      bucket:                                                                                      "${google_storage_bucket.bucket.name}"
      default_acl:                                                                                 "projectPrivate"


Plan: 8 to add, 0 to change, 0 to destroy.
```
