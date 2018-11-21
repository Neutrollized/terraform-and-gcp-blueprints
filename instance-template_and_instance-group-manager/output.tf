output "instance_template" {
  value = "${google_compute_instance_template.web_template.*.self_link}"
}

// like the above, except output is not as a list, but a string (first element)
output "instance_group" {
  value = "${element(google_compute_instance_group_manager.web_igm1.*.instance_group, 0)}"
}

// when you output data variables, they must be 4 parts:
// data.TYPE.NAME.ATTRIBUTE
// igm_instances returns a list of lists [[],[]], so flatten will turn it into one big list instead 
output "igm_instances" {
  value = "${flatten(data.google_compute_instance_group.igm1_data_source.*.instances)}"
}

/*
output "instance_url" {
  value = "${data.google_compute_instance.gce_data_source.*}"
}
*/

