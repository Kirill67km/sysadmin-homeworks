resource  "local_file" "inventoryfile" {
     filename="${abspath(path.module)}/ansible/hosts.cfg"
     content= templatefile("${abspath(path.module)}/ansible/hosts.tftpl",{
        webservers= [for i in yandex_compute_instance.web: i ] 
        databases=  [for k,v in yandex_compute_instance.db: v ] 
        storages= tolist( [yandex_compute_instance.storage])  
     })  
 }