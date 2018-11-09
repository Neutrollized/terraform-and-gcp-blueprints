data "google_compute_image" "my_image" {
  project = "ubuntu-os-cloud"
  family  = "ubuntu-minimal-1804-lts"
}

resource "google_compute_instance_template" "web_template" {
  name = "webserver-template"
  description = "template for creating server instance"

  instance_description = "Ubuntu Xenial minimal instance with Apache2"
  machine_type = "${var.machine_type}"
  can_ip_forward = false

  scheduling {
    on_host_maintenance = "MIGRATE"
  }

  disk {
    #source_image = "${format("%v/%v", var.image_project, var.image_family)}"
    source_image = "${data.google_compute_image.my_image.self_link}"
    auto_delete = true
    boot = true
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  metadata_startup_script = "apt-get update && apt-get -y install apache2"
}
