provider "google" {
  credentials = "${file("./creds/serviceaccount.json")}"
  project     = "rock-drake-245918"
  region      = "europe-west3"
  zone        = "europe-west3-a"
}
