# Домашнее задание к занятию 10 «Jenkins»

## Подготовка к выполнению

1. Создать два VM: для jenkins-master и jenkins-agent.
2. Установить Jenkins при помощи playbook.
3. Запустить и проверить работоспособность.
4. Сделать первоначальную настройку.

## Основная часть

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.

![freestyle](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/software/screenshots/freestyle.png)

3. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.

![declarative](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/software/screenshots/declarative.png)

5. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.
6. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.

![multibranch](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/software/screenshots/multibranch.png)

![multibranch_two](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/software/screenshots/multibranch_two.png)

8. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).

![scripted_jenkins](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/software/screenshots/scripted_jenkins.png)

10. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True). По умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.
11. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.
12. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.

[Declarative Pipeline](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/software/ansible-jenkins/Jenkinsfile)

[Scripted Pipeline](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/software/pipeline/ScriptedJenkinsfile)

13. Сопроводите процесс настройки скриншотами для каждого пункта задания!!

## Необязательная часть

1. Создать скрипт на groovy, который будет собирать все Job, завершившиеся хотя бы раз неуспешно. Добавить скрипт в репозиторий с решением и названием `AllJobFailure.groovy`.
2. Создать Scripted Pipeline так, чтобы он мог сначала запустить через Yandex Cloud CLI необходимое количество инстансов, прописать их в инвентори плейбука и после этого запускать плейбук. Мы должны при нажатии кнопки получить готовую к использованию систему.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
