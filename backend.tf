terraform {
  backend "gcs" {
    bucket = "terraform-state-encodeflush"
    prefix = "tf-k8s/state"
  }
}
