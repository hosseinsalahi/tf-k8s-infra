/*
* Create Kubespray Inventory File
*
*/
data "template_file" "inventory" {
  template = "${file("${path.module}/templates/inventory.tpl")}"

  vars = {
    public_ip_address_bastion = "${join("\n", formatlist("bastion ansible_host=%s", aws_instance.bastion-server.*.public_ip))}"
    connection_strings_master = "${join("\n", formatlist("%s ansible_host=%s", google_compute_instance.k8s_master.*.network_interface.0.network_ip))}"
    connection_strings_node   = "${join("\n", formatlist("%s ansible_host=%s", google_compute_instance.k8s_worker.*.network_interface.0.network_ip))}"
    connection_strings_etcd   = "${join("\n", formatlist("%s ansible_host=%s", google_compute_instance.k8s_master.*.network_interface.0.network_ip))}"
    list_master               = "${join("\n", master)}"
    list_node                 = "${join("\n", worker)}"
    list_etcd                 = "${join("\n", etcd)}"
  }
}

resource "null_resource" "inventories" {
  provisioner "local-exec" {
    command = "echo '${data.template_file.inventory.rendered}' > ${var.inventory_file}"
  }

  triggers = {
    template = "${data.template_file.inventory.rendered}"
  }
