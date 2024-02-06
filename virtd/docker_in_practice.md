# Домашнее задание к занятию 5. «Практическое применение Docker»

### Инструкция к выполнению

1. Для выполнения заданий обязательно ознакомьтесь с [инструкцией](https://github.com/netology-code/devops-materials/blob/master/cloudwork.MD) по экономии облачных ресурсов. Это нужно, чтобы не расходовать средства, полученные в результате использования промокода.
3. Своё решение к задачам оформите в вашем GitHub репозитории.
4. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.
5. Сопроводите ответ необходимыми скриншотами.

---
## Примечание: Ознакомьтесь со схемой виртуального стенда [по ссылке](https://github.com/netology-code/shvirtd-example-python/blob/main/schema.pdf)

---

## Задача 1
1. Сделайте в своем github пространстве fork репозитория ```https://github.com/netology-code/shvirtd-example-python/blob/main/README.md```.   
2. Создайте файл с именем ```Dockerfile.python``` для сборки данного проекта. Используйте базовый образ ```python:3.9-slim```. Протестируйте корректность сборки. Не забудьте dockerignore.
3. (Необязательная часть, *) Изучите инструкцию в проекте и запустите web-приложение без использования docker в venv. (Mysql БД можно запустить в docker run).
4. (Необязательная часть, *) По образцу предоставленного python кода внесите в него исправление для управления названием используемой таблицы через ENV переменную.

![docker-practice](https://github.com/Kirill67km/sysadmin-homeworks/blob/main/virtd/screenshots/задание_1.png)

![docker-practice](https://github.com/Kirill67km/sysadmin-homeworks/blob/main/virtd/screenshots/задание_1_2.png)

![docker-practice](https://github.com/Kirill67km/sysadmin-homeworks/blob/main/virtd/screenshots/задание_1_3.png)

## Задача 2 (*)
1. Создайте в yandex cloud container registry с именем "test" с помощью "yc tool" . [Инструкция](https://cloud.yandex.ru/ru/docs/container-registry/quickstart/?from=int-console-help)
2. Настройте аутентификацию вашего локального docker в yandex container registry.
3. Соберите и залейте в него образ с python приложением из задания №1.
4. Просканируйте образ на уязвимости.
5. В качестве ответа приложите отчет сканирования.

[отчет сканирования](https://github.com/Kirill67km/sysadmin-homeworks/blob/main/virtd/screenshots/задание_2.csv)

## Задача 3
1. Создайте файл ```compose.yaml```. Опишите в нем следующие сервисы: 

- ```web```. Образ приложения должен ИЛИ собираться при запуске compose из файла ```Dockerfile.python``` ИЛИ скачиваться из yandex cloud container registry(из задание №2 со *). Контейнер должен работать в bridge-сети с названием ```backend``` и иметь фиксированный ipv4-адрес ```172.20.0.5```. Сервис должен всегда перезапускаться в случае ошибок.
Передайте необходимые ENV-переменные для подключения к Mysql базе данных по сетевому имени сервиса ```web``` 

- ```db```. image=mysql:8. Контейнер должен работать в bridge-сети с названием ```backend``` и иметь фиксированный ipv4-адрес ```172.20.0.10```. Явно перезапуск сервиса в случае ошибок. Передайте необходимые ENV-переменные для создания: пароля root пользователя, создания базы данных, пользователя и пароля для web-приложения.Обязательно используйте .env file для назначения секретных ENV-переменных!

2. Запустите проект локально с помощью docker compose , добейтесь его стабильной работы.Протестируйте приложение с помощью команд ```curl -L http://127.0.0.1:8080``` и ```curl -L http://127.0.0.1:8090```.

5. Подключитесь к БД mysql с помощью команды ```docker exec <имя_контейнера> mysql -uroot -p<пароль root-пользователя>``` . Введите последовательно команды (не забываем в конце символ ; ): ```show databases; use <имя вашей базы данных(по-умолчанию example)>; show tables; SELECT * from requests LIMIT 10;```.

6. Остановите проект. В качестве ответа приложите скриншот sql-запроса.

![docker-practice](https://github.com/Kirill67km/sysadmin-homeworks/blob/main/virtd/screenshots/задание_3.png)

## Задача 4
1. Запустите в Yandex Cloud ВМ (вам хватит 2 Гб Ram).
2. Подключитесь к Вм по ssh и установите docker.
3. Напишите bash-скрипт, который скачает ваш fork-репозиторий в каталог /opt и запустит проект целиком.
4. Зайдите на сайт проверки http подключений, например(или аналогичный): ```https://check-host.net/check-http``` и запустите проверку вашего сервиса ```http://<внешний_IP-адрес_вашей_ВМ>:5000```.
5. (Необязательная часть) Дополнительно настройте remote ssh context к вашему серверу. Отобразите список контекстов и результат удаленного выполнения ```docker ps -a```
6. В качестве ответа повторите  sql-запрос и приложите скриншот с данного сервера, bash-скрипт и ссылку на fork-репозиторий.

![docker-practice](https://github.com/Kirill67km/sysadmin-homeworks/blob/main/virtd/screenshots/задание_4.png)

```bash
#!/bin/bash
echo 'Запускаю скрипт'
echo 'Изменяю директорию на /opt'
cd /opt || exit 1

echo 'Копирую репозиторий со сборкой'
sudo git clone https://github.com/Kirill67km/shvirtd-example-python.git || exit 1

echo 'Переход в директорию проекта'
cd shvirtd-example-python || exit 1

echo 'Создаю и активирую виртуальное окружение'
python3 -m venv venv || exit 1
source venv/bin/activate || exit 1

echo 'Устанавливаю зависимости'
pip install -r requirements.txt || exit 1

echo 'Запускаю приложение'
nohup python main.py > /dev/null 2>&1 &

echo 'Процесс запущен в фоновом режиме'
```

[fork-репозиторий](https://github.com/Kirill67km/shvirtd-example-python)

## Задача 5 (*)
1. Напишите и задеплойте на вашу облачную ВМ bash скрипт, который произведет резервное копирование БД mysql в директорию "/opt/backup" с помощью запуска в сети "backend" контейнера из образа ```schnitzler/mysqldump``` при помощи ```docker run ...``` команды. Подсказка: "документация образа."
2. Протестируйте ручной запуск
3. Настройте выполнение скрипта раз в 1 минуту через cron, crontab или systemctl timer.
4. Предоставьте скрипт, cron-task и скриншот с несколькими резервными копиями в "/opt/backup"

```bash
#!/bin/bash

# Проверка наличия привилегий пользователя
if [[ $EUID -ne 0 ]]; then
   echo "Этот скрипт требует прав root. Запустите его с использованием sudo."
   exit 1
fi

# Ваш скрипт продолжает выполнение с правами root

# Создаем директорию для резервных копий
backup_dir="/opt/backup"
mkdir -p "$backup_dir"

# Опции подключения к MySQL
db_user="root"
db_password="admin"
db_name="example"
mysql_container="mysql-container"
db_host="172.17.0.2"

# Имя файла для резервной копии
backup_file="$backup_dir/backup_$(date +'%Y%m%d%H%M%S').sql"

# Запускаем контейнер для выполнения mysqldump
sudo docker exec "$mysql_container" mysqldump \
  --host="$db_host" \
  --user="$db_user" \
  --password="$db_password" \
  "$db_name" > "$backup_file"

echo "Резервная копия выполнена и сохранена в $backup_file"
```

![docker-practice](https://github.com/Kirill67km/sysadmin-homeworks/blob/main/virtd/screenshots/задание_5.png)

## Задача 6
Скачайте docker образ ```hashicorp/terraform:latest``` и скопируйте бинарный файл ```/bin/terraform``` на свою локальную машину, используя dive и docker save.
Предоставьте скриншоты  действий .

```bash
#Сохраняем образ в архив
sudo docker save hashicorp/terraform:latest -o  image.tar

#Использование утилиты dive
sudo dive hashicorp/terraform:latest

#Вытаскиваем бинарный файл
cat terraform_image.tar | tar -xO | jq -r '.[0].Layers["e27646a588fb9ce75afee962a7ed397636930b084890f7e50016939448e3936c"].Raw' | tar -xvf - -C /tmp terraform
```

## Задача 6.1
Добейтесь аналогичного результата, используя docker cp.  
Предоставьте скриншоты  действий .

```bash
#Копируем бинарный файл /bin/terraform на  локальную машину

docker create --name temp-container hashicorp/terraform:latest
docker cp temp-container:/bin/terraform ./terraform
docker rm temp-container
```


## Задача 6.2 (**)
Предложите способ извлечь файл из контейнера, используя только команду docker build и любой Dockerfile.  
Предоставьте скриншоты  действий .

## Задача 7 (***)
Запустите ваше python-приложение с помощью runC, не используя docker или containerd.  
Предоставьте скриншоты  действий .
