variable "subnet_cidr" {
  default = "10.127.0.0/20"
}

variable "network_name" {
  default = "labor"
}

variable "k8s_machine_type" {
  type = string
}

variable "k8s_image_type" {
  type = string
}

variable "bastion_image_type" {
  type = string
}

variable "bastion_machine_type" {
  type = string
}

variable "master_name" {
  type = string
}

variable "worker_name" {
  type = string
}

variable "bastion_name" {
  type = string
}

variable "master_count" {
  default = 1
}

variable "worker_count" {
  default = 1
}

variable "bucket" {
  type = string
}
