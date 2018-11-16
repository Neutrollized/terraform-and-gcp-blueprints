output "filestore_ip" {
  value = "${element(google_filestore_instance.nfs_server1.networks.0.ip_addresses, 0)}"
}

output "nfsclient_nic0_ip" {
  value = "${google_compute_instance.nfs_client.network_interface.0.network_ip}"
}

output "nfsclient_nic1_ip" {
  value = "${google_compute_instance.nfs_client.network_interface.1.network_ip}"
}

output "nfsclient_ext_ip" {
  value = "${google_compute_instance.nfs_client.network_interface.0.access_config.0.nat_ip}"
}
