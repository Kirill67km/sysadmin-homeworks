В файле ".gitignore" созданы правила, по которым мы будем игнорировать файлы по заданному шаблону, а именно:

 Local .terraform directories (локальные директории с .terraform)
**/.terraform/*

 .tfstate files (файлы, которые либо имеют в своем составе "tfstate" или имеют такое расширение)
*.tfstate
*.tfstate.*

 Crash log files (файлы crash-логов с расширением "log" и имеющими в своем составе "crash")
crash.log
crash.*.log

 Exclude all .tfvars files, which are likely to contain sensitive data, such as
 password, private keys, and other secrets. These should not be part of version 
 control as they are data points which are potentially sensitive and subject 
 to change depending on the environment. (исключаем файлы с расширением "tfvars" и "tfvars.json", которые содержат чувствительные данные)
*.tfvars
*.tfvars.json

 Ignore override files as they are usually used to override resources locally and so
 are not checked in (игнорируем файлы с "override")
override.tf
override.tf.json
*_override.tf
*_override.tf.json

 Include override files you do wish to add to version control using negated pattern
 !example_override.tf

 Include tfplan files to ignore the plan output of command: terraform plan -out=tfplan
 example: *tfplan*

Ignore CLI configuration files (файлы конфигурации terraformmc)

.terraformrc
terraform.rc
