resource  "local_file" "inventoryfile" {
     filename="${abspath(path.module)}/ansible/hosts.cfg"
     content= templatefile("${abspath(path.module)}/ansible/hosts.tftpl",{
        webservers= [for i in yandex_compute_instance.web: i ] 
        databases=  [for k,v in yandex_compute_instance.db: v ] 
        storages= tolist( [yandex_compute_instance.storage])  
     })  
 }

resource "null_resource" "web_hosts_provision" {
 depends_on = [yandex_compute_instance.web,yandex_compute_instance.db,yandex_compute_instance.storage ]

  provisioner "local-exec" {
      command = "ssh-add /home/galchonkov/.ssh/id_ed25519"
  }

  provisioner "local-exec" {
    command = "sleep 60"
  } 
 
  provisioner "local-exec" {                  
    command  = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i \"${abspath(path.module)}/ansible/hosts.cfg\" \"${abspath(path.module)}/ansible/playbook.yaml\""
    on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }


    triggers = {  
      always_run         = "${timestamp()}" 
      playbook_src_hash  = file("${abspath(path.module)}/ansible/playbook.yaml") 
      ssh_public_key     = var.vms_ssh_root_key
    }

}