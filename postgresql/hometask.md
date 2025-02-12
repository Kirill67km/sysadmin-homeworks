# Домашнее задание к занятию «SQL и реляционные СУБД.Введение в PostgreSQL»

### Цель задания

* объяснить основу реляционной модели данных;
* знать назначение языка SQL и его основные конструкции;
* иметь представление об основных реляционных СУБД;
* понимать разницу в уровнях изоляции транзакций.

### Компетенции

* владение базовыми навыками работы в SQL

------------

## Задание 1. Настройка ВМ в YandexCloud. Установка пакета PostgreSQL 14

* создать новый проект в Яндекс облако
* далее создать инстанс виртуальной машины с дефолтными параметрами

![YandexCloud](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_1.png)

* добавить свой ssh ключ в metadata ВМ
* зайти удаленным ssh (первая сессия), не забывайте про ssh-add

![SSH](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_2.png)

* поставить PostgreSQL

![PSQL](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_4.png)

* зайти вторым ssh (вторая сессия)
* запустить везде psql из под пользователя postgres
* выключить auto commit

![AC1](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_5.png)

![AC2](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_6.png)
