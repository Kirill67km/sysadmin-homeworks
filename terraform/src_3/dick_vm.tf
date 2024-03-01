resource "yandex_compute_disk" "storage_disk" {
  count = 3
  name       = "storage-disk-${tostring(count.index + 1)}"
  type       = "network-hdd"
  zone       = "ru-central1-a"
  size       = 1
}

resource "yandex_compute_instance" "storage" {  
  name        = "storage"
  platform_id = "standard-v1"
   
  dynamic "secondary_disk" {
    for_each = { for s in yandex_compute_disk.storage_disk[*]: s.name=> s }
    content {
        disk_id=secondary_disk.value.id
    }
  }
   

  resources {
    cores  = 2
    memory =  1
    core_fraction = 20 
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type =  "network-hdd"
      size = 5
    }   
  }

  metadata = local.vms_metadata

  scheduling_policy { preemptible = true }

  network_interface { 
    subnet_id = yandex_vpc_subnet.netology.id
    nat       = true
  }
  allow_stopping_for_update = true
}