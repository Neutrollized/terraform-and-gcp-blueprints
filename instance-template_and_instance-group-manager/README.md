# Instance Template & Instance Group Manager

[Compute Instance Template](https://www.terraform.io/docs/providers/google/r/compute_instance_template.html)

[Compute Instance Group Manager](https://www.terraform.io/docs/providers/google/r/compute_instance_group_manager.html)

[Compute Region (multi-zone) Instance Group Manager](https://www.terraform.io/docs/providers/google/r/compute_region_instance_group_manager.html)


There's not option within the instance template resource to "Allow HTTP traffic" or "Allow HTTPS traffic" as one might from the Cloud Console.  If you want that here, you'll have to create a firewall rule to allow tcp:80 or tcp:443 traffic for your instance that you create from the template.


```
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.google_compute_image.my_image: Refreshing state...

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

 <= data.google_compute_instance_group.igm1_data_source
      id:                                                  <computed>
      description:                                         <computed>
      instances.#:                                         <computed>
      named_port.#:                                        <computed>
      network:                                             <computed>
      project:                                             <computed>
      self_link:                                           "${google_compute_instance_group_manager.web_igm1.instance_group}"
      size:                                                <computed>
      zone:                                                <computed>

  + google_compute_instance_group_manager.web_igm1
      id:                                                  <computed>
      base_instance_name:                                  "ubuntu-web-igm"
      fingerprint:                                         <computed>
      instance_group:                                      <computed>
      instance_template:                                   "${google_compute_instance_template.web_template.self_link}"
      name:                                                "ubuntu-web-igm"
      project:                                             <computed>
      self_link:                                           <computed>
      target_size:                                         "2"
      update_strategy:                                     "REPLACE"
      version.#:                                           <computed>
      wait_for_instances:                                  "true"
      zone:                                                "us-central1-c"

  + google_compute_instance_template.web_template
      id:                                                  <computed>
      can_ip_forward:                                      "false"
      description:                                         "template for creating server instance"
      disk.#:                                              "1"
      disk.0.auto_delete:                                  "true"
      disk.0.boot:                                         "true"
      disk.0.device_name:                                  <computed>
      disk.0.disk_type:                                    <computed>
      disk.0.interface:                                    <computed>
      disk.0.mode:                                         <computed>
      disk.0.source_image:                                 "https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-minimal-1804-bionic-v20181203"
      disk.0.type:                                         <computed>
      instance_description:                                "Ubuntu Xenial minimal instance with Apache2"
      labels.%:                                            "3"
      labels.environment:                                  "test"
      labels.osfamily:                                     "linux"
      labels.osname:                                       "ubuntu-1604"
      machine_type:                                        "f1-micro"
      metadata.%:                                          "1"
      metadata.sshKeys:                                    "glen:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDX6CRSh9aZdC5fiK+WmXpB269ZN/gRYp0EXWZxucaE/W10hk+iVM1z0d5sDQSHcJ9CL7zIUTPS7Q3vf/RFwoK+EmboW2JV1B4QnCSpeboD+hHGygtqoznNTHqhI09v8/O8woYd1Uzuvhv9rdyI8S/puY+DDTyjBi3T5CeACdtdpgvtp700pwigvUS6lbjE9ocJRZHT+J7V30Fc01E6uwwFZEurBBNiotTpEcYyxa8je49y0MAumxeHgxujGatOcXN/3QGNq4FiO8it46jDLhSHPJzYwIZ/v+hLokL9WCAbU5YlFSeUhsm31RPvr3lkzADQYYkIvtXKEay9NEZ3eZxp\n"
      metadata_fingerprint:                                <computed>
      metadata_startup_script:                             "apt-get update && apt-get -y install apache2"
      name:                                                "webserver-template"
      name_prefix:                                         <computed>
      network_interface.#:                                 "1"
      network_interface.0.access_config.#:                 "1"
      network_interface.0.access_config.0.assigned_nat_ip: <computed>
      network_interface.0.access_config.0.nat_ip:          <computed>
      network_interface.0.access_config.0.network_tier:    <computed>
      network_interface.0.address:                         <computed>
      network_interface.0.network:                         "default"
      network_interface.0.network_ip:                      <computed>
      network_interface.0.subnetwork_project:              <computed>
      project:                                             <computed>
      region:                                              <computed>
      scheduling.#:                                        "1"
      scheduling.0.automatic_restart:                      "true"
      scheduling.0.on_host_maintenance:                    "MIGRATE"
      scheduling.0.preemptible:                            "false"
      self_link:                                           <computed>
      tags_fingerprint:                                    <computed>


Plan: 2 to add, 0 to change, 0 to destroy.
```
