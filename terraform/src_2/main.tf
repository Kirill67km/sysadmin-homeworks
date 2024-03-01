resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family #"ubuntu-2004-lts"
}
resource "yandex_compute_instance" "default" {
  name        = local.vm_web_instance_name    #"netology-develop-platform-web"
  platform_id = var.vm_web_platform #"standard-v1"
  resources {
    cores         = var.vms_resources.vm_web_resources.cores #2
    memory        = var.vms_resources.vm_web_resources.memory #4
    core_fraction = var.vms_resources.vm_web_resources.core_fraction #5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}

resource "yandex_compute_instance" "db" {
  name        = local.vm_db_instance_name    #"netology-develop-platform-db"
  platform_id = var.vm_db_platform #"standard-v1"
  #zone        = var.vm_db_zone
  resources {
    cores         = var.vms_resources.vm_db_resources.cores #2
    memory        = var.vms_resources.vm_db_resources.memory #2
    core_fraction = var.vms_resources.vm_db_resources.core_fraction #20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}