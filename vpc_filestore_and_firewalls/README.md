# VPCs, Firestore and Firewall rules

[Compute Network](https://www.terraform.io/docs/providers/google/r/compute_network.html)

[Filestore Instance](https://www.terraform.io/docs/providers/google/r/filestore_instance.html)

[Compute Firewall](https://www.terraform.io/docs/providers/google/r/compute_firewall.html)


Create a VPC to place a Google managed NFS server, [Cloud Filestore](https://cloud.google.com/filestore/) and then a compute instance with dual-NICs -- one on the default network, and the other on the authorized network the Filestore allows.  Of course, you'll need the proper firewall rules to support it.

In this example, I also use various [provisioners](https://www.terraform.io/docs/provisioners/index.html) to configure the NFS-client (configure static route, add `/etc/fstab` entry and finally mount the Cloud Filestore share) running on Centos-7.


```
var.filestore_sharename
  Enter a value: myshare


Warning: google_filestore_instance.nfs_server1: This resource is in beta and will be removed from this provider.
Use the FilestoreInstance resource in the terraform-provider-google-beta provider to continue using it.
See https://terraform.io/docs/providers/google/provider_versions.html for more details on beta resources.



Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + google_compute_firewall.filestore-egress
      id:                                                  <computed>
      allow.#:                                             "2"
      allow.1778683946.ports.#:                            "3"
      allow.1778683946.ports.0:                            "111"
      allow.1778683946.ports.1:                            "2049"
      allow.1778683946.ports.2:                            "4045"
      allow.1778683946.protocol:                           "udp"
      allow.4178948407.ports.#:                            "4"
      allow.4178948407.ports.0:                            "111"
      allow.4178948407.ports.1:                            "662"
      allow.4178948407.ports.2:                            "2049"
      allow.4178948407.ports.3:                            "4045"
      allow.4178948407.protocol:                           "tcp"
      creation_timestamp:                                  <computed>
      destination_ranges.#:                                <computed>
      direction:                                           "EGRESS"
      name:                                                "filestore-egress"
      network:                                             "filestore-network"
      priority:                                            "1000"
      project:                                             <computed>
      self_link:                                           <computed>
      source_ranges.#:                                     <computed>
      target_tags.#:                                       "1"
      target_tags.1201918879:                              "nfs"

  + google_compute_firewall.filestore-ingress
      id:                                                  <computed>
      allow.#:                                             "2"
      allow.1486604749.ports.#:                            "0"
      allow.1486604749.protocol:                           "udp"
      allow.3848845357.ports.#:                            "0"
      allow.3848845357.protocol:                           "tcp"
      creation_timestamp:                                  <computed>
      destination_ranges.#:                                <computed>
      direction:                                           <computed>
      name:                                                "filestore-ingress"
      network:                                             "filestore-network"
      priority:                                            "1000"
      project:                                             <computed>
      self_link:                                           <computed>
      source_ranges.#:                                     <computed>
      target_tags.#:                                       "1"
      target_tags.1201918879:                              "nfs"

  + google_compute_instance.nfs_client
      id:                                                  <computed>
      allow_stopping_for_update:                           "true"
      boot_disk.#:                                         "1"
      boot_disk.0.auto_delete:                             "true"
      boot_disk.0.device_name:                             <computed>
      boot_disk.0.disk_encryption_key_sha256:              <computed>
      boot_disk.0.initialize_params.#:                     "1"
      boot_disk.0.initialize_params.0.image:               "centos-cloud/centos-7"
      boot_disk.0.initialize_params.0.size:                <computed>
      boot_disk.0.initialize_params.0.type:                <computed>
      can_ip_forward:                                      "false"
      cpu_platform:                                        <computed>
      create_timeout:                                      "4"
      deletion_protection:                                 "false"
      guest_accelerator.#:                                 <computed>
      instance_id:                                         <computed>
      label_fingerprint:                                   <computed>
      machine_type:                                        "f1-micro"
      metadata.%:                                          "1"
      metadata.sshKeys:                                    "glen:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDX6CRSh9aZdC5fiK+WmXpB269ZN/gRYp0EXWZxucaE/W10hk+iVM1z0d5sDQSHcJ9CL7zIUTPS7Q3vf/RFwoK+EmboW2JV1B4QnCSpeboD+hHGygtqoznNTHqhI09v8/O8woYd1Uzuvhv9rdyI8S/puY+DDTyjBi3T5CeACdtdpgvtp700pwigvUS6lbjE9ocJRZHT+J7V30Fc01E6uwwFZEurBBNiotTpEcYyxa8je49y0MAumxeHgxujGatOcXN/3QGNq4FiO8it46jDLhSHPJzYwIZ/v+hLokL9WCAbU5YlFSeUhsm31RPvr3lkzADQYYkIvtXKEay9NEZ3eZxp\n"
      metadata_fingerprint:                                <computed>
      metadata_startup_script:                             "yum -y install nfs-utils"
      name:                                                "nfs-client"
      network_interface.#:                                 "2"
      network_interface.0.access_config.#:                 "1"
      network_interface.0.access_config.0.assigned_nat_ip: <computed>
      network_interface.0.access_config.0.nat_ip:          <computed>
      network_interface.0.access_config.0.network_tier:    "STANDARD"
      network_interface.0.address:                         <computed>
      network_interface.0.name:                            <computed>
      network_interface.0.network:                         "default"
      network_interface.0.network_ip:                      <computed>
      network_interface.0.subnetwork_project:              <computed>
      network_interface.1.address:                         <computed>
      network_interface.1.name:                            <computed>
      network_interface.1.network_ip:                      <computed>
      network_interface.1.subnetwork:                      "${google_compute_subnetwork.my_subnet1.self_link}"
      network_interface.1.subnetwork_project:              <computed>
      project:                                             <computed>
      scheduling.#:                                        <computed>
      self_link:                                           <computed>
      tags.#:                                              "1"
      tags.1201918879:                                     "nfs"
      tags_fingerprint:                                    <computed>
      zone:                                                "us-central1-c"

  + google_compute_network.my_network1
      id:                                                  <computed>
      auto_create_subnetworks:                             "false"
      gateway_ipv4:                                        <computed>
      name:                                                "filestore-network"
      project:                                             <computed>
      routing_mode:                                        <computed>
      self_link:                                           <computed>

  + google_compute_subnetwork.my_subnet1
      id:                                                  <computed>
      creation_timestamp:                                  <computed>
      fingerprint:                                         <computed>
      gateway_address:                                     <computed>
      ip_cidr_range:                                       "10.242.0.0/24"
      name:                                                "filestore-subnet"
      network:                                             "${google_compute_network.my_network1.self_link}"
      project:                                             <computed>
      region:                                              "us-central1"
      secondary_ip_range.#:                                <computed>
      self_link:                                           <computed>

  + google_filestore_instance.nfs_server1
      id:                                                  <computed>
      create_time:                                         <computed>
      etag:                                                <computed>
      file_shares.#:                                       "1"
      file_shares.0.capacity_gb:                           "1024"
      file_shares.0.name:                                  "myshare"
      name:                                                "nfs-server"
      networks.#:                                          "1"
      networks.0.ip_addresses.#:                           <computed>
      networks.0.modes.#:                                  "1"
      networks.0.modes.0:                                  "MODE_IPV4"
      networks.0.network:                                  "filestore-network"
      networks.0.reserved_ip_range:                        <computed>
      project:                                             <computed>
      tier:                                                "STANDARD"
      zone:                                                "us-central1-c"


Plan: 6 to add, 0 to change, 0 to destroy.
```
