data "google_compute_image" "my_image" {
  project = "ubuntu-os-cloud"
  family  = "ubuntu-minimal-1804-lts"
}

// gcloud compute instance-templates create webserver-template
resource "google_compute_instance_template" "web_template" {
  name        = "webserver-template"
  description = "template for creating server instance"

  instance_description = "Ubuntu Xenial minimal instance with Apache2"
  machine_type         = "${var.machine_type}"
  can_ip_forward       = false

  scheduling {
    on_host_maintenance = "MIGRATE"
  }

  disk {
    // source_image = "${format("%v/%v", var.image_project, var.image_family)}"
    source_image = "${data.google_compute_image.my_image.self_link}"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "default"

    access_config {}
  }

  // optional, but if you wanted to add labels, this is how you would do it
  labels {
    environment = "test"
    osfamily    = "linux"
    osname      = "ubuntu-1604"
  }

  // add in ssh public key as metadata key/value pairs
  // https://cloud.google.com/compute/docs/instances/adding-removing-ssh-keys
  metadata {
    // sshKeys = "${var.ssh_user}:${file(lookup(var.ssh_pubkey, var.ssh_user))}"
    sshKeys = "${var.ssh_user}:${file("${var.public_key_file_path}")}"
  }

  metadata_startup_script = "apt-get update && apt-get -y install apache2"

  lifecycle {
    create_before_destroy = true
  }
}

// gcloud compute instance-groups managed create ubuntu-web-igm
resource "google_compute_instance_group_manager" "web_igm1" {
  name              = "ubuntu-web-igm"
  instance_template = "${google_compute_instance_template.web_template.self_link}"

  // instances in this group will get the base_instance_name + 4 random chars
  base_instance_name = "ubuntu-web-igm"
  zone               = "${var.zone}"
  wait_for_instances = true

  target_size = "2"
}

data "google_compute_instance_group" "igm1_data_source" {
  self_link = "${google_compute_instance_group_manager.web_igm1.instance_group}"
}

/*
data "google_compute_instance" "gce_data_source" {
  self_link = "${flatten(data.google_compute_instance_group.igm1_data_source.*.instances)}"
}
*/


/*
// region instance group manager is slightly more complicated
// and also less available outputs from datasource
resource "google_compute_region_instance_group_manager" "web_rigm1" {
  name              = "ubuntu-web-rigm"
  instance_template = "${google_compute_instance_template.web_template.self_link}"

  // instances in this group will get the base_instance_name + 4 random chars
  base_instance_name        = "ubuntu-web-rigm"
  region                    = "${var.region}"
  distribution_policy_zones = "${var.igm_zones}"
  wait_for_instances        = true

  target_size = "${var.count}"
}

// with a datasource, you can get more information that you normally wouldn't be able to
// for example: instances/instance names isn't one of the argument references for rigm
// https://www.terraform.io/docs/providers/google/d/datasource_compute_region_instance_group.html
data "google_compute_region_instance_group" "rigm1_data_source" {
  self_link = "${google_compute_region_instance_group_manager.web_rigm1.instance_group}"
}
*/

