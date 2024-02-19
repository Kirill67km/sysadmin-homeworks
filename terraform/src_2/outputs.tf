output "vm_instance_info" {
  description = "Information about the VM instances"
  value = {
    db = {
      instance_name = yandex_compute_instance.db.name
      external_ip   = yandex_compute_instance.db.network_interface[0].nat_ip_address
      fqdn          = "${yandex_compute_instance.db.name}.${yandex_vpc_subnet.develop.name}.${yandex_vpc_subnet.develop.folder_id}.internal"
    }
    platform = {
      instance_name = yandex_compute_instance.default.name
      external_ip   = yandex_compute_instance.default.network_interface[0].nat_ip_address
      fqdn          = "${yandex_compute_instance.default.name}.${yandex_vpc_subnet.develop.name}.${yandex_vpc_subnet.develop.folder_id}.internal"
    }
  }
}