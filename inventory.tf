/*
* Create Kubespray Inventory File
*
*/
data "template_file" "inventory" {
  template = "${file("${path.module}/templates/inventory.tpl")}"

  vars = {
    connection_strings_master  = join("\n", formatlist("%s ansible_host=%s", google_compute_instance.k8s_master.*.name, google_compute_instance.k8s_master.*.network_interface.0.network_ip))
    #connection_strings_master = 
    #connection_strings_node   = "${join("\n", format("%s ansible_host=%s", google_compute_instance.k8s_worker.*.network_interface.0.network_ip))}"
    #connection_strings_etcd   = "${join("\n", format("%s ansible_host=%s", google_compute_instance.k8s_master.*.network_interface.0.network_ip))}"
    #list_master               = "${join("\n", google_compute_instance.k8s_master.*.network_ip)}"
    #list_node                 = "${join("\n", google_compute_instance.k8s_master.*.network_ip)}"
    #list_etcd                 = "${join("\n", google_compute_instance.k8s_master.*.network_ip)}"
  }
}

resource "null_resource" "inventories" {
  provisioner "local-exec" {
    command = "echo '${data.template_file.inventory.rendered}' > ${var.inventory_file}"
  }

  triggers = {
    template = "${data.template_file.inventory.rendered}"
  }
}
