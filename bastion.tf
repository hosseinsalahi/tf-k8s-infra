resource "google_compute_instance" "k8s_bastion" {
  name         = var.bastion_name
  machine_type = var.bastion_machine_type

  tags = ["k8s", "lb", "ssh"]

  boot_disk {
    initialize_params {
      image = var.bastion_image_type
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.k8s-subnet.name
    access_config {
      nat_ip = google_compute_address.k8s-nat-address.1.address
    }
  }
}
