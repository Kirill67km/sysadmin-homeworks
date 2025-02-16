# Домашнее задание к занятию «Установка и настройка PostgteSQL в контейнере Docker»

### Цель задания

* установить PostgreSQL в Docker контейнере
* настроить контейнер для внешнего подключения

### Компетенции

* установка PostgreSQL

------------

## Задание 1. Настройка ВМ в YandexCloud. Установка docker и PostgreSQL 15

* создать ВМ с Ubuntu 20.04/22.04 или развернуть докер любым удобным способом
* поставить на нем Docker Engine* поставить на нем Docker Engine
* сделать каталог /var/lib/postgres
* развернуть контейнер с PostgreSQL 15 смонтировав в него /var/lib/postgresql
* развернуть контейнер с клиентом postgres

``` yaml
version: '3.9'
services:
  postgres:
    image: postgres:15
    container_name: postgres_container
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: postgres_db
      PGDATA: /var/lib/postgresql/data/pgdata
    ports:
      - "5430:5432"
    volumes:
      - ./pgdata:/var/lib/postgresql/data/pgdata
    deploy:
      resources:
        limits:
          cpus: '0.50'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 256M
    command: >
      postgres -c max_connections=1000
               -c shared_buffers=256MB
               -c effective_cache_size=768MB
               -c maintenance_work_mem=64MB
               -c checkpoint_completion_target=0.7
               -c wal_buffers=16MB
               -c default_statistics_target=100
    healthcheck:
      test: [ "CMD-SHELL", "pg_isready -U postgres -d postgres_db" ]
      interval: 30s
      timeout: 10s
      retries: 5
    restart: unless-stopped
    tty: true
    stdin_open: true
volumes:
  pgdata:
    driver: local
```

---
Пояснение: за основу взята статья https://habr.com/ru/articles/823816/

Краткий обзор Docker Compose файла

* services/postgres:

    - image: используемая Docker-образ PostgreSQL, в данном случае postgres:latest.
    - container_name: имя контейнера, в котором будет запущен PostgreSQL.
    - environment: переменные окружения для настройки PostgreSQL (пользователь, пароль, имя базы данных)
    - ports: проброс портов, где "5430:5432" означает, что порт PostgreSQL внутри контейнера (5432) проброшен на порт     хоста (5430). Это значит что для подключения к постгрес нужно будет прописывать порт 5430.
    - volumes: монтируем локальный каталог ./pgdata внутрь контейнера для сохранения данных PostgreSQL.
    - deploy: определяет ресурсы и стратегию развертывания для Docker Swarm (необязательно для стандартного использования Docker Compose).
    - command: дополнительные параметры командной строки PostgreSQL для настройки параметров производительности.
    - healthcheck: проверка состояния PostgreSQL с использованием pg_isready.
    - restart, tty, stdin_open: настройки перезапуска контейнера и взаимодействия с ним через терминал.

* volumes/pgdata:

    - определяет том pgdata, который используется для постоянного хранения данных PostgreSQL

---

* подключится из контейнера с клиентом к контейнеру с сервером и сделать таблицу с парой строк

``` sql
CREATE table persons(id serial, first_name text, second_name text);
INSERT into persons(first_name, second_name) values('ivan', 'ivanov');
INSERT into persons(first_name, second_name) values('petr', 'petrov');
COMMIT;
```

![PSQL-1](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/ht2/img/psql_1.png)

* подключится к контейнеру с сервером с ноутбука/компьютера извне инстансов ЯО/места установки докера

![PSQL-2](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/ht2/img/psql_2_1.png)

![PSQL-2-1](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/ht2/img/psql_2.png)

* удалить контейнер с сервером и создать его заново

![PSQL-3](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/ht2/img/psql_3.png)

![PSQL-4](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/ht2/img/psql_4.png)
* подключится снова из контейнера с клиентом к контейнеру с сервером и проверить, что данные остались на месте

![PSQL-5](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/ht2/img/psql_5.png)

![PSQL-6](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/ht2/img/psql_6.png)