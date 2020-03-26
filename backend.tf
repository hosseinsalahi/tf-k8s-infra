terraform {
  backend "gcs" {
    bucket = "terraform-state-encodeflush"
    prefix = "tf-gce-instance"
  }
}
