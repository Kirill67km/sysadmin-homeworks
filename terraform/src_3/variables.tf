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
  description = "VPC network&subnet name"
}

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPS3W9Y/lrgvrOKfqM4ioAxVwmS7FzxxEIEYTYb9rher galchonkov@python-ml"
  description = "ssh-keygen -t ed25519"
}

variable "vms_settings"{
  type=list(object({ vm_name=string, cpu=number, ram=number, disk=number }))
  default = [{
    vm_name="main"
    cpu=2
    ram=8
    disk=10
  },
  {
    vm_name="replica"
    cpu=4
    ram=16
    disk=20
  }]
}

variable "vms_defset"{
  type=object({platform_id=string,disktype=string,disksize=number,resources=map(number)})
  default={
    platform_id = "standard-v1"
    disktype = "network-hdd"
    disksize = 5
    resources = {
      cpu=2
      ram=8  
    }
  }
} 