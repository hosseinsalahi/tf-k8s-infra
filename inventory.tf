/*
* Create Kubespray Inventory File
*
*/
data "template_file" "inventory" {
  template = file("${path.module}/templates/inventory.tpl")

  vars = {
    connection_strings_master = join("\n", formatlist("%s ansible_host=%s", google_compute_instance.k8s_master.*.name, google_compute_instance.k8s_master.*.network_interface.0.network_ip))
    connection_strings_node   = join("\n", formatlist("%s ansible_host=%s", google_compute_instance.k8s_master.*.name, google_compute_instance.k8s_master.*.network_interface.0.network_ip))
    connection_strings_etcd   = join("\n", formatlist("%s ansible_host=%s", google_compute_instance.k8s_master.*.name, google_compute_instance.k8s_master.*.network_interface.0.network_ip))
    list_master               = join("\n", google_compute_instance.k8s_master.*.name)
    list_node                 = join("\n", google_compute_instance.k8s_worker.*.name)
    list_etcd                 = join("\n", google_compute_instance.k8s_master.*.name)
  }
}

resource "google_storage_bucket_object" "inventory" {
  name    = "hosts"
  content = data.template_file.inventory.rendered
  bucket  = var.bucket
}
