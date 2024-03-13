resource "yandex_compute_instance" "web" {
  count = 2

  name        = "netology-develop-platform-web-${count.index + 1}"
  platform_id = var.vms_defset.platform_id

  resources {
    cores         = var.vms_defset.resources.cpu
    memory        = var.vms_defset.resources.cpu
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vms_defset.disktype
      size     = var.vms_defset.disktype
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${var.vms_ssh_root_key}"
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.netology.id
    nat       = true

    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  allow_stopping_for_update = true
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}
