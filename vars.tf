variable "machine_type" {
   type    = string
}

variable "image_type" {
   type    = string
}

variable "master_name" {
  type = string
}

variable "worker_name" {
  type = string
}

variable "master_count" {
  default = 1
}

variable "worker_count" {
  default = 1
}

#variable "ssh_user" {
#  type = string
#}

#variable "ssh_key" {
#  type = string
#}
