resource "google_compute_instance" "k8s_master" {
  count        = var.master_count
  name         = "${var.master_name}${count.index + 1}"
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = var.image_type
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
  #metadata = {
  #  sshKeys = "${var.ssh_user}:${var.ssh_key}" 
  #}
}

resource "google_compute_instance" "k8s_worker" {
  count        = var.worker_count
  name         = "${var.worker_name}${count.index + 1}"
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = var.image_type
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
  #metadata = {
  #  sshKeys = "${var.ssh_user}:${var.ssh_key}"
  #}
}
