output "instance_template" {
  value = "${google_compute_instance_template.web_template.*.self_link}"
}

output "region_instance_group" {
  value = "${element(concat(google_compute_region_instance_group_manager.web_rigm1.*.instance_group,list("")), 0)}"
}

// when you output data variables, they must be 4 parts:
// data.TYPE.NAME.ATTRIBUTE
output "rigm_instances" {
  value = "${data.google_compute_region_instance_group.rigm1_data_source.instances}"
}
