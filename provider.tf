provider "google" {
  credentials = "${file("${var.shared_credentials_file}")}"
  project     = "${var.shared_credentials_file}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}
