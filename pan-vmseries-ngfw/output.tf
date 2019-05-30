output "bucket-name" {
  value = "${module.bootstrap_bucket.bucket_name}"
}

output "firewall-name" {
  value = "${google_compute_instance.firewall.*.name}"
}

output "firewall-untrust-ips-for-nat-healthcheck" {
  value = "${google_compute_instance.firewall.*.network_interface.0.address}"
}

output "firewall-management-external-ips" {
  value = "${google_compute_instance.firewall.*.network_interface.1.access_config.0.nat_ip}"
}

/*
output "elb_public_ip" {
  value = "${google_compute_global_forwarding_rule.default.ip_address}"
}

output "internal-lb-ip-for-nat-healthcheck" {
  value = "${google_compute_forwarding_rule.my-int-lb-forwarding-rule.ip_address}"
}
*/

