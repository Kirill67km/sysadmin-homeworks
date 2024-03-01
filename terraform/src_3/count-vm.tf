resource "yandex_compute_instance" "web" {
  count = 2

  name        = "netology-develop-platform-web-${count.index + 1}"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = 5
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${var.vms_ssh_root_key}"
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.netology.id
    nat       = true
  }
  allow_stopping_for_update = true
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}