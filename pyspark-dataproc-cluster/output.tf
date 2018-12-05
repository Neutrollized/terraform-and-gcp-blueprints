output "cluster_master_names" {
  value = "${google_dataproc_cluster.my_pyspark_cluster.cluster_config.0.master_config.0.instance_names}"
}

output "cluster_worker_names" {
  value = "${google_dataproc_cluster.my_pyspark_cluster.cluster_config.0.worker_config.0.instance_names}"
}

output "cluster_preemptible_worker_names" {
  value = "${google_dataproc_cluster.my_pyspark_cluster.cluster_config.0.preemptible_worker_config.0.instance_names}"
}
