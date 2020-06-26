
resource "local_file" "fedora-coreos-ign" {
  content = data.ct_config.bootstrap.rendered
  filename = "${path.module}/output/fedora-coreos.ign"
}

data "ct_config" "bootstrap" {
  content      = file("user-data/bootstrap.yaml")
  strict       = true
  pretty_print = true
}
