resource "google_compute_network" "my_dataproc_network" {
  name = "dataproc-network"

  //defaults to true.  false = --subnet-mode custom
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "my_dataproc_subnetwork" {
  name          = "dataproc-subnetwork"
  ip_cidr_range = "192.168.30.0/24"
  region        = "${var.region}"
  network       = "${google_compute_network.my_dataproc_network.self_link}"
}

resource "google_compute_firewall" "my_dataproc_firewall_internal" {
  name    = "${google_compute_network.my_dataproc_network.name}-allow-internal"
  network = "${google_compute_network.my_dataproc_network.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  source_ranges = ["${google_compute_subnetwork.my_dataproc_subnetwork.ip_cidr_range}"]
}

resource "google_compute_firewall" "my_dataproc_firewall_ssh" {
  name    = "${google_compute_network.my_dataproc_network.name}-allow-ssh"
  network = "${google_compute_network.my_dataproc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource random_string "default" {
  length  = 8
  special = false
}

module "my_dataproc_staging_bucket" {
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

resource "google_dataproc_cluster" "my_pyspark_cluster" {
  name   = "pyspark-cluster"
  region = "${var.region}"

  cluster_config {
    staging_bucket = "${module.my_dataproc_staging_bucket.bucket_name}"

    gce_cluster_config {
      zone = "${var.zone}"

      //network    = "${google_compute_network.my_dataproc_network.name}"
      subnetwork = "${google_compute_subnetwork.my_dataproc_subnetwork.name}"
    }

    master_config {
      num_instances = "${var.num_masters}"
      machine_type  = "${var.machine_type}"

      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = "${var.boot_disk_size_gb}"
      }
    }

    worker_config {
      num_instances = "${var.num_workers}"
      machine_type  = "${var.machine_type}"

      disk_config {
        boot_disk_size_gb = "${var.boot_disk_size_gb}"
        num_local_ssds    = 1
      }
    }

    preemptible_worker_config {
      num_instances = "${var.num_preemptible_workers}"
    }

    software_config {
      image_version = "${var.sw_image_version}"

      override_properties = {
        "dataproc:dataproc.allow.zero.workers" = "true"
      }
    }

    # https://github.com/GoogleCloudPlatform/dataproc-initialization-actions
    initialization_action {
      script      = "gs://${var.init_actions_bucket}/${var.init_actions_repo}/${var.init_actions_repo}.sh"
      timeout_sec = 500
    }
  }
}
