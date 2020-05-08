output "master_ip" {
  value = google_compute_instance.k8s_master.*.network_interface.0.network_ip
}

output "worker_ip" {
  value = google_compute_instance.k8s_worker.*.network_interface.0.network_ip
}

output "lb_ip" {
  value = google_compute_instance.k8s_loadbalancer.*.network_interface.0.network_ip
}

output "hosts" {
	value = "\n${data.template_file.inventory.rendered}"
}
