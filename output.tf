output "master_ip" {
  value = "${google_compute_instance.k8s_master.*.network_interface.0.access_config}"
}

output "worker_ip" {
  value = "${google_compute_instance.k8s_worker.*.network_interface.0.access_config}"
}
