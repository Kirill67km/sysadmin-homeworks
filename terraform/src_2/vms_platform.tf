###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPS3W9Y/lrgvrOKfqM4ioAxVwmS7FzxxEIEYTYb9rher galchonkov@python-ml"
  description = "ssh-keygen -t ed25519"
}

###web

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "family"
}

#variable "vm_web_name" {
#  type        = string
#  default     = "netology-develop-platform-web"
#  description = "web_name"
#}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v1"
  description = "web_platform"
}

#variable "vm_web_cores" {
#  type        = string
#  default     = "2"
#  description = "web_cores"
#}

#variable "vm_web_memory" {
#  type        = string
#  default     = "4"
#  description = "web_memory"
#}

#variable "vm_web_core_fraction" {
#  type        = string
#  default     = "5"
#  description = "web_cores_fraction"
#}

#variable "vm_db_name" {
#  type        = string
#  default     = "netology-develop-platform-db"
#  description = "web_name"
#}

variable "vm_db_platform" {
  type        = string
  default     = "standard-v1"
  description = "db_platform"
}

#variable "vm_db_cores" {
#  type        = string
#  default     = "2"
#  description = "db_cores"
#}

#variable "vm_db_memory" {
#  type        = string
#  default     = "2"
#  description = "db_memory"
#}

#variable "vm_db_core_fraction" {
#  type        = string
#  default     = "20"
#  description = "db_cores_fraction"
#}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "vm_db_zone"
}

variable "vms_resources" {
  type        = map(map(number))
  default     = {
  vm_web_resources = {
    cores          = 2
    memory         = 4
    core_fraction  = 5
  }
  vm_db_resources = {
    cores         = 2
    memory        = 2
    core_fraction = 20
    }
  }
  variable "metadata" {
  type        = map(map(number))
  default     = {
  serial-port-enable = 1
  ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
    }
  }
}