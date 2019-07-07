provider "google" {
  credentials = "${file(var.shared_credentials_file)}"
  project     = "${var.project}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}
