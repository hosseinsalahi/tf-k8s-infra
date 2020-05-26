resource "google_compute_firewall" "lb-ssh" {
  name    = "loadbalancer-ssh"
  network = google_compute_network.k8s-nw.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "icmp"
  }

  target_tags = ["ssh"]
}

resource "google_compute_firewall" "lb-https" {
  name    = "loadbalancer-https"
  network = google_compute_network.k8s-nw.self_link

  allow {
    protocol = "tcp"
    ports    = ["443", "6443", "8443"]
  }

  target_tags = ["lb"]
}

resource "google_compute_firewall" "allow-internal" {
  name    = "${var.network_name}-fw-allow-internal"
  network = google_compute_network.k8s-nw.self_link
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  source_ranges = [
    google_compute_subnetwork.k8s-subnet.ip_cidr_range
  ]
}
