resource "google_compute_network" "k8s-nw" {
  name = "${var.network_name}-nw"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "k8s-subnet" {
  name = var.network_name
  ip_cidr_range = var.subnet_cidr
  network = google_compute_network.k8s-nw.self_link
  private_ip_google_access = true
}

resource "google_compute_address" "k8s-nat-address" {
  count = 2
  name = "nat-manual-ip-${count.index}"
}

resource "google_compute_router" "k8s-router" {
  name = "${var.network_name}-nat-router"
  network = google_compute_network.k8s-nw.self_link
}

resource "google_compute_router_nat" "k8s-nat" {
  name = "${var.network_name}-nat-gw"
  router = google_compute_router.k8s-router.name
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips = [google_compute_address.k8s-nat-address.0.self_link]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  depends_on = [google_compute_address.k8s-nat-address]
}
