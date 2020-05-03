resource "google_compute_instance" "k8s_loadbalancer" {
  name         = var.lb_name
  machine_type = var.lb_machine_type

  tags = ["k8s", "lb", "ssh"]

  boot_disk {
    initialize_params {
      image = var.lb_image_type
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.k8s-subnet.name
    access_config {
      nat_ip = google_compute_address.k8s-nat-address.1.address
    }
  }
}
