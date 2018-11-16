// gcloud compute networks create filestore-network --subnet-mode custom
resource "google_compute_network" "my_network1" {
  name = "filestore-network"

  //defaults to true.  false = --subnet-mode custom
  auto_create_subnetworks = "false"
}

// gcloud compute networks subnet create filestore-subnet --network custom-network --range 10.242.0.0./24
resource "google_compute_subnetwork" "my_subnet1" {
  name          = "filestore-subnet"
  ip_cidr_range = "10.242.0.0/24"
  network       = "${google_compute_network.my_network1.self_link}"
  region        = "${var.region}"
}

resource "google_filestore_instance" "nfs_server1" {
  name = "nfs-server"
  zone = "${var.zone}"
  tier = "${var.filestore_tier}"

  file_shares {
    capacity_gb = 1024

    name = "${var.filestore_sharename}"
  }

  networks {
    network = "${google_compute_network.my_network1.name}"
    modes   = ["MODE_IPV4"]

    // optional /29 CIDR block for IP range of the NFS server
    // reserved_ip_range = "10.0.0.0/29"
  }
}

// https://cloud.google.com/filestore/docs/configuring-firewall
resource "google_compute_firewall" "filestore-ingress" {
  name    = "filestore-ingress"
  network = "${google_compute_network.my_network1.name}"

  allow {
    protocol = "tcp"

    // portmapper 111, statd 662, nlockmgr 4045
    // ports = ["111", "662", "4045"]
  }

  allow {
    protocol = "udp"

    // portmapper 111, nlockmgr 4045
    // ports = ["111", "4045"]
  }

  source_ranges = ["${element(google_filestore_instance.nfs_server1.networks.0.ip_addresses, 0)}"]

  target_tags = ["${var.tags}"]
}

resource "google_compute_firewall" "filestore-egress" {
  name      = "filestore-egress"
  network   = "${google_compute_network.my_network1.name}"
  direction = "EGRESS"

  allow {
    protocol = "tcp"

    // portmapper 111, statd 662, nfs 2049, nlockmgr 4045
    ports = ["111", "662", "2049", "4045"]
  }

  allow {
    protocol = "udp"

    // portmapper 111, nfs 2049, nlockmgr 4045
    ports = ["111", "2049", "4045"]
  }

  destination_ranges = ["${element(google_filestore_instance.nfs_server1.networks.0.ip_addresses, 0)}"]

  target_tags = ["${var.tags}"]
}

resource "google_compute_instance" "nfs_client" {
  name                      = "nfs-client"
  machine_type              = "${var.machine_type}"
  zone                      = "${var.zone}"
  allow_stopping_for_update = "true"

  tags = ["${var.tags}"]

  boot_disk {
    initialize_params {
      image = "${format("%v/%v", var.image_project, var.image_family)}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      network_tier = "STANDARD"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.my_subnet1.self_link}"
  }

  // add in ssh public key as metadata key/value pairs
  // https://cloud.google.com/compute/docs/instances/adding-removing-ssh-keys
  metadata {
    sshKeys = "${var.ssh_user}:${file("${var.public_key_file_path}")}"
  }

  metadata_startup_script = "yum -y install nfs-utils"

  connection {
    type        = "ssh"
    host        = "${self.network_interface.0.access_config.0.nat_ip}"
    user        = "${var.ssh_user}"
    private_key = "${file("${var.private_key_file_path}")}"
  }

  provisioner "file" {
    source      = "scripts/filestore-client-config.sh"
    destination = "/tmp/filestore-client-config.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/filestore-client-config.sh",
      "sudo /tmp/filestore-client-config.sh ${element(google_filestore_instance.nfs_server1.networks.0.ip_addresses, 0)} ${google_compute_subnetwork.my_subnet1.gateway_address}",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p ${var.nfs_mnt_pt}",
      "echo '#added by Terraform' | sudo tee -a /etc/fstab",
      "echo '${element(google_filestore_instance.nfs_server1.networks.0.ip_addresses, 0)}:/${var.filestore_sharename}  ${var.nfs_mnt_pt}  nfs  defaults  0 0' | sudo tee -a /etc/fstab",
      "sudo mount ${var.nfs_mnt_pt}",
    ]
  }
}
