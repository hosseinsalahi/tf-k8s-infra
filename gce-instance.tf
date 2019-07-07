resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
  metadata = {
      sshKeys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGTxKpE4LzojL6Vo7BVFuHFNIbdRZHa/S2q98eMd7n8G encodeflush@lx-02013529" 
  }

}
