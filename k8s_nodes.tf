resource "google_compute_instance" "k8s_master" {
  count        = var.master_count
  name         = "${var.master_name}${count.index + 1}"
  machine_type = var.k8s_machine_type

  tags = ["k8s", "master", "controller"]

  boot_disk {
    initialize_params {
      image = var.k8s_image_type
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.k8s-subnet.name
  }
}

resource "google_compute_disk" "k8s_worker" {
  count = var.worker_count
  name  = "persistent-disk-${count.index + 1}"
  type  = "pd-standard"
  size  = "25"
}


resource "google_compute_attached_disk" "k8s_worker" {
  count    = var.worker_count
  disk     = google_compute_disk.k8s_worker.*.self_link[count.index]
  instance = google_compute_instance.k8s_worker.*.self_link[count.index]
}

resource "google_compute_instance" "k8s_worker" {
  count        = var.worker_count
  name         = "${var.worker_name}${count.index + 1}"
  machine_type = var.k8s_machine_type

  tags = ["k8s", "worker"]

  boot_disk {
    initialize_params {
      image = var.k8s_image_type
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.k8s-subnet.name
  }
  
  lifecycle {
    ignore_changes = [attached_disk]
  }
}
