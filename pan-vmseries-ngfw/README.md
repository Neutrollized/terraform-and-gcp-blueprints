# PAN VM-Series Next Gen FW

The Palo Alto Networks VM-Series next-generation firewall.  Wow, what a mouthful!  It's runs PAN-OS on a VM that you can provision in your cloud environment (in this case, GCP) that is both a very powerful and scalable solution.  You can learn more about it [here](https://www.youtube.com/watch?v=ly9830IL35Q) if you wish.

Here's a diagram of how the setup/layout would generally look:

<img width="261" alt="image" src="https://user-images.githubusercontent.com/30295405/41330798-57d56954-6e8a-11e8-8fe0-6954803b103b.png">


## Notes

[bootstrap process](https://www.paloaltonetworks.com/documentation/81/virtualization/virtualization/bootstrap-the-vm-series-firewall/bootstrap-package#id88dce8d3-3665-4794-b7ed-0fd47581ebd2)

[management interface swap in GCP](https://www.paloaltonetworks.com/documentation/81/virtualization/virtualization/set-up-the-vm-series-firewall-on-google-cloud-platform/deploy-the-vm-series-firewall-on-google-cloud/management-interface-mapping-for-google-internal-load-balancing)


After deploying the resources in this blueprint, you will have to ssh in as `admin` to the external IP of your management interface/NIC using the ssh-key you created.  You should then receive the prompt below and can then set the admin password for the PAN-OS UI (go to https://`firewall-management-external-ips` where you can login) 


```
Welcome admin.
admin@PA-VM> configure
Entering configuration mode
[edit]
admin@PA-VM# set mgt-config users admin password
Enter password   :
Confirm password :

[edit]
admin@PA-VM# commit



Commit job 2 is in progress. Use Ctrl+C to return to command prompt
...55%99%.......100%
Configuration committed successfully

[edit]
admin@PA-VM# exit
Exiting configuration mode
admin@PA-VM> exit
```


```
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.google_client_config.current: Refreshing state...

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + google_compute_firewall.allow-inbound
      id:                                                  <computed>
      allow.#:                                             "2"
      allow.1367131964.ports.#:                            "0"
      allow.1367131964.protocol:                           "icmp"
      allow.186047796.ports.#:                             "2"
      allow.186047796.ports.0:                             "80"
      allow.186047796.ports.1:                             "22"
      allow.186047796.protocol:                            "tcp"
      creation_timestamp:                                  <computed>
      destination_ranges.#:                                <computed>
      direction:                                           <computed>
      name:                                                "allow-inbound"
      network:                                             "${google_compute_network.untrust.self_link}"
      priority:                                            "1000"
      project:                                             <computed>
      self_link:                                           <computed>
      source_ranges.#:                                     "1"
      source_ranges.1080289494:                            "0.0.0.0/0"

  + google_compute_firewall.allow-mgmt
      id:                                                  <computed>
      allow.#:                                             "2"
      allow.1367131964.ports.#:                            "0"
      allow.1367131964.protocol:                           "icmp"
      allow.805075243.ports.#:                             "2"
      allow.805075243.ports.0:                             "443"
      allow.805075243.ports.1:                             "22"
      allow.805075243.protocol:                            "tcp"
      creation_timestamp:                                  <computed>
      destination_ranges.#:                                <computed>
      direction:                                           <computed>
      name:                                                "allow-mgmt"
      network:                                             "${google_compute_network.management.self_link}"
      priority:                                            "1000"
      project:                                             <computed>
      self_link:                                           <computed>
      source_ranges.#:                                     "1"
      source_ranges.1080289494:                            "0.0.0.0/0"

  + google_compute_firewall.allow-outbound
      id:                                                  <computed>
      allow.#:                                             "1"
      allow.1870923232.ports.#:                            "0"
      allow.1870923232.protocol:                           "all"
      creation_timestamp:                                  <computed>
      destination_ranges.#:                                <computed>
      direction:                                           <computed>
      name:                                                "allow-outbound"
      network:                                             "${google_compute_network.trust.self_link}"
      priority:                                            "1000"
      project:                                             <computed>
      self_link:                                           <computed>
      source_ranges.#:                                     "1"
      source_ranges.1080289494:                            "0.0.0.0/0"

  + google_compute_instance.firewall
      id:                                                  <computed>
      allow_stopping_for_update:                           "true"
      boot_disk.#:                                         "1"
      boot_disk.0.auto_delete:                             "true"
      boot_disk.0.device_name:                             <computed>
      boot_disk.0.disk_encryption_key_sha256:              <computed>
      boot_disk.0.initialize_params.#:                     "1"
      boot_disk.0.initialize_params.0.image:               "https://www.googleapis.com/compute/v1/projects/paloaltonetworksgcp-public/global/images/vmseries-byol-810"
      boot_disk.0.initialize_params.0.size:                "60"
      boot_disk.0.initialize_params.0.type:                "pd-standard"
      can_ip_forward:                                      "true"
      cpu_platform:                                        <computed>
      deletion_protection:                                 "false"
      guest_accelerator.#:                                 <computed>
      instance_id:                                         <computed>
      label_fingerprint:                                   <computed>
      machine_type:                                        "n1-standard-4"
      metadata.%:                                          <computed>
      metadata_fingerprint:                                <computed>
      min_cpu_platform:                                    "Intel Skylake"
      name:                                                "firewall-1"
      network_interface.#:                                 "3"
      network_interface.0.access_config.#:                 "1"
      network_interface.0.access_config.0.assigned_nat_ip: <computed>
      network_interface.0.access_config.0.nat_ip:          <computed>
      network_interface.0.access_config.0.network_tier:    <computed>
      network_interface.0.address:                         <computed>
      network_interface.0.name:                            <computed>
      network_interface.0.network_ip:                      <computed>
      network_interface.0.subnetwork:                      "${google_compute_subnetwork.untrust-sub.self_link}"
      network_interface.0.subnetwork_project:              <computed>
      network_interface.1.access_config.#:                 "1"
      network_interface.1.access_config.0.assigned_nat_ip: <computed>
      network_interface.1.access_config.0.nat_ip:          <computed>
      network_interface.1.access_config.0.network_tier:    <computed>
      network_interface.1.address:                         <computed>
      network_interface.1.name:                            <computed>
      network_interface.1.network_ip:                      <computed>
      network_interface.1.subnetwork:                      "${google_compute_subnetwork.management-sub.self_link}"
      network_interface.1.subnetwork_project:              <computed>
      network_interface.2.address:                         <computed>
      network_interface.2.name:                            <computed>
      network_interface.2.network_ip:                      <computed>
      network_interface.2.subnetwork:                      "${google_compute_subnetwork.trust-sub.self_link}"
      network_interface.2.subnetwork_project:              <computed>
      project:                                             <computed>
      scheduling.#:                                        <computed>
      self_link:                                           <computed>
      service_account.#:                                   "1"
      service_account.0.email:                             <computed>
      service_account.0.scopes.#:                          "4"
      service_account.0.scopes.1632638332:                 "https://www.googleapis.com/auth/devstorage.read_only"
      service_account.0.scopes.172152165:                  "https://www.googleapis.com/auth/logging.write"
      service_account.0.scopes.3804780973:                 "https://www.googleapis.com/auth/cloud.useraccounts.readonly"
      service_account.0.scopes.4177124133:                 "https://www.googleapis.com/auth/monitoring.write"
      tags_fingerprint:                                    <computed>
      zone:                                                "us-central1-c"

  + google_compute_network.management
      id:                                                  <computed>
      auto_create_subnetworks:                             "false"
      delete_default_routes_on_create:                     "false"
      gateway_ipv4:                                        <computed>
      name:                                                "management"
      project:                                             <computed>
      routing_mode:                                        <computed>
      self_link:                                           <computed>

  + google_compute_network.trust
      id:                                                  <computed>
      auto_create_subnetworks:                             "false"
      delete_default_routes_on_create:                     "false"
      gateway_ipv4:                                        <computed>
      name:                                                "trust"
      project:                                             <computed>
      routing_mode:                                        <computed>
      self_link:                                           <computed>

  + google_compute_network.untrust
      id:                                                  <computed>
      auto_create_subnetworks:                             "false"
      delete_default_routes_on_create:                     "false"
      gateway_ipv4:                                        <computed>
      name:                                                "untrust"
      project:                                             <computed>
      routing_mode:                                        <computed>
      self_link:                                           <computed>

  + google_compute_project_metadata_item.ssh-keys
      id:                                                  <computed>
      key:                                                 "ssh-keys"
      project:                                             <computed>
      value:                                               "admin:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDX6CRSh9aZdC5fiK+WmXpB269ZN/gRYp0EXWZxucaE/W10hk+iVM1z0d5sDQSHcJ9CL7zIUTPS7Q3vf/RFwoK+EmboW2JV1B4QnCSpeboD+hHGygtqoznNTHqhI09v8/O8woYd1Uzuvhv9rdyI8S/puY+DDTyjBi3T5CeACdtdpgvtp700pwigvUS6lbjE9ocJRZHT+J7V30Fc01E6uwwFZEurBBNiotTpEcYyxa8je49y0MAumxeHgxujGatOcXN/3QGNq4FiO8it46jDLhSHPJzYwIZ/v+hLokL9WCAbU5YlFSeUhsm31RPvr3lkzADQYYkIvtXKEay9NEZ3eZxp admin"

  + google_compute_route.trust
      id:                                                  <computed>
      dest_range:                                          "0.0.0.0/0"
      name:                                                "trust-route"
      network:                                             "${google_compute_network.trust.self_link}"
      next_hop_instance:                                   "firewall-1"
      next_hop_instance_zone:                              "us-central1-c"
      next_hop_network:                                    <computed>
      priority:                                            "100"
      project:                                             <computed>
      self_link:                                           <computed>

  + google_compute_subnetwork.management-sub
      id:                                                  <computed>
      creation_timestamp:                                  <computed>
      fingerprint:                                         <computed>
      gateway_address:                                     <computed>
      ip_cidr_range:                                       "10.0.0.0/24"
      name:                                                "management-sub"
      network:                                             "${google_compute_network.management.self_link}"
      project:                                             <computed>
      region:                                              "us-central1"
      secondary_ip_range.#:                                <computed>
      self_link:                                           <computed>

  + google_compute_subnetwork.trust-sub
      id:                                                  <computed>
      creation_timestamp:                                  <computed>
      fingerprint:                                         <computed>
      gateway_address:                                     <computed>
      ip_cidr_range:                                       "10.0.2.0/24"
      name:                                                "trust-sub"
      network:                                             "${google_compute_network.trust.self_link}"
      project:                                             <computed>
      region:                                              "us-central1"
      secondary_ip_range.#:                                <computed>
      self_link:                                           <computed>

  + google_compute_subnetwork.untrust-sub
      id:                                                  <computed>
      creation_timestamp:                                  <computed>
      fingerprint:                                         <computed>
      gateway_address:                                     <computed>
      ip_cidr_range:                                       "10.0.1.0/24"
      name:                                                "untrust-sub"
      network:                                             "${google_compute_network.untrust.self_link}"
      project:                                             <computed>
      region:                                              "us-central1"
      secondary_ip_range.#:                                <computed>
      self_link:                                           <computed>

  + google_storage_bucket_object.folders[0]
      id:                                                  <computed>
      bucket:                                              "${module.bootstrap_bucket.bucket_name}"
      content:                                             <sensitive>
      content_type:                                        <computed>
      crc32c:                                              <computed>
      detect_md5hash:                                      "different hash"
      md5hash:                                             <computed>
      name:                                                "config/"
      output_name:                                         <computed>
      self_link:                                           <computed>
      storage_class:                                       <computed>

  + google_storage_bucket_object.folders[1]
      id:                                                  <computed>
      bucket:                                              "${module.bootstrap_bucket.bucket_name}"
      content:                                             <sensitive>
      content_type:                                        <computed>
      crc32c:                                              <computed>
      detect_md5hash:                                      "different hash"
      md5hash:                                             <computed>
      name:                                                "license/"
      output_name:                                         <computed>
      self_link:                                           <computed>
      storage_class:                                       <computed>

  + google_storage_bucket_object.folders[2]
      id:                                                  <computed>
      bucket:                                              "${module.bootstrap_bucket.bucket_name}"
      content:                                             <sensitive>
      content_type:                                        <computed>
      crc32c:                                              <computed>
      detect_md5hash:                                      "different hash"
      md5hash:                                             <computed>
      name:                                                "software/"
      output_name:                                         <computed>
      self_link:                                           <computed>
      storage_class:                                       <computed>

  + google_storage_bucket_object.folders[3]
      id:                                                  <computed>
      bucket:                                              "${module.bootstrap_bucket.bucket_name}"
      content:                                             <sensitive>
      content_type:                                        <computed>
      crc32c:                                              <computed>
      detect_md5hash:                                      "different hash"
      md5hash:                                             <computed>
      name:                                                "content/"
      output_name:                                         <computed>
      self_link:                                           <computed>
      storage_class:                                       <computed>

  + random_string.default
      id:                                                  <computed>
      length:                                              "8"
      lower:                                               "true"
      min_lower:                                           "0"
      min_numeric:                                         "0"
      min_special:                                         "0"
      min_upper:                                           "0"
      number:                                              "true"
      result:                                              <computed>
      special:                                             "false"
      upper:                                               "true"

  + module.bootstrap_bucket.google_storage_bucket.bucket
      id:                                                  <computed>
      force_destroy:                                       "true"
      labels.%:                                            "1"
      labels.managed-by:                                   "terraform"
      location:                                            "US-CENTRAL1"
      logging.#:                                           "1"
      logging.0.log_bucket:                                "${local.log_bucket_name}"
      logging.0.log_object_prefix:                         <computed>
      name:                                                "${var.bucket_name}"
      project:                                             "zoey-215712"
      self_link:                                           <computed>
      storage_class:                                       "REGIONAL"
      url:                                                 <computed>
      versioning.#:                                        "1"
      versioning.0.enabled:                                "true"

  + module.bootstrap_bucket.google_storage_bucket_acl.bucket_acl
      id:                                                  <computed>
      bucket:                                              "${google_storage_bucket.bucket.name}"
      default_acl:                                         "projectPrivate"


Plan: 19 to add, 0 to change, 0 to destroy.
```
