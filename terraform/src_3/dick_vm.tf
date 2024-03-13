resource "yandex_compute_disk" "storage_disk" {
  count = 3
  name       = "storage-disk-${tostring(count.index + 1)}"
  type       = var.vms_defset.disktype
  zone       = "ru-central1-a"
  size       = 1
}

resource "yandex_compute_instance" "storage" {  
  name        = "storage"
  platform_id = var.vms_defset.platform_id
   
  dynamic "secondary_disk" {
    for_each = { for s in yandex_compute_disk.storage_disk : s.name => s }
    content {
        disk_id=secondary_disk.value.id
    }
  }

  resources {
    cores  = var.vms_defset.resources.cpu
    memory =  var.vms_defset.resources.ram
    core_fraction = 20 
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type =  var.vms_defset.disktype
      size =  var.vms_defset.disksize
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