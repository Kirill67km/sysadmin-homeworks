# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению

1. Установите Ansible версии 2.10 или выше.
2. Создайте свой публичный репозиторий на GitHub с произвольным именем.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.

![task_1](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/ansible/images/ansible_1/task_1.png)

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.

![task_2](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/ansible/images/ansible_1/task_2.png)

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.

![task_3](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/ansible/images/ansible_1/task_3.png)

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.
6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.

![task_5](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/ansible/images/ansible_1/task_5.png)

8. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.

![task_7](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/ansible/images/ansible_1/task_7.png)

9. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.

![task_8](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/ansible/images/ansible_1/task_8.png)

10. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

![task_9](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/ansible/images/ansible_1/task_9.png)

11. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
12. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.

![task_11](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/ansible/images/ansible_1/task_11.png)

13. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
14. Предоставьте скриншоты результатов запуска команд.

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.

![task_1*](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/ansible/images/ansible_1/task_1*.png)

2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.

![task_2*](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/ansible/images/ansible_1/task_2*.png)

3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.

![task_3*](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/ansible/images/ansible_1/task_3*.png)

4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).


![task_4*](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/ansible/images/ansible_1/task_4*.png)

5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
