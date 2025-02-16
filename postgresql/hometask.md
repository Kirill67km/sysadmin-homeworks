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

## Задание 2. Создание таблицы и наполнение ее данными. Ответы на вопросы

* выполнить sql-запрос

``` sql
CREATE table persons(id serial, first_name text, second_name text);
INSERT into persons(first_name, second_name) values('ivan', 'ivanov');
INSERT into persons(first_name, second_name) values('petr', 'petrov');
COMMIT;
```

![SQL-запрос](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_6.png)


* посмотреть текущий уровень изоляции: show transaction isolation level

``` sql
SHOW transaction isolation level;
```
![SQL-запрос-2](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_7.png)

* начать новую транзакцию в обоих сессиях с дефолтным (не меняя) уровнем изоляции

``` sql
START TRANSACTION;
```

![SQL-запрос-3](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_8.png)

* в первой сессии добавить новую запись 

``` sql
INSERT INTO persons(first_name, second_name) VALUES('sergey', 'sergeev');
```

![SQL-запрос-4](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_9.png)

* выполнить во второй сессии select from persons

``` sql
SELECT * from persons;
```

![SQL-запрос-5](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_10.png)

---
Видите ли вы новую запись и если да то почему?

*Ответ:* новую запись мы не видим, так как используется уровень изоляции READ COMMITTED, а это значит, что вторая сессия увидит новые данные только после комммита в первой
---


* завершить первую транзакцию и выполните запрос на получение данных

``` sql
COMMIT;
```

``` sql
SELECT * from persons;
```

![SQL-запрос-6](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_11.png)

![SQL-запрос-7](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_12.png)

---
Видите ли вы новую запись и если да то почему?

*Ответ:* новую запись мы видим, так как в первой сессии произошла фиксация изменений, что позволило во второй сессии увидеть новые данные
---

* завершите транзакцию во второй сессии

``` sql
COMMIT;
```

* начать новые но уже repeatable read транзации

``` sql
BEGIN;
SET transaction isolation level repeatable read;
START TRANSACTION;
```

* в первой сессии добавить новую запись и получить данные во второй

``` sql
INSERT into persons(first_name, second_name) values('liza', 'lizova');
```

``` sql
SELECT * from persons;
```

![SQL-запрос-8](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_13.png)

![SQL-запрос-9](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_14.png)

---
Видите ли вы новую запись и если да то почему?

*Ответ:* новую запись мы не видим, так как вторая сессия работает со снимком данных, сделанным в моменте старта ее транзакции
---

* завершить первую транзакцию и сделать запрос данных во второй 

``` sql
COMMIT;
```

``` sql
SELECT * from persons;
```

![SQL-запрос-10](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_15.png)

![SQL-запрос-11](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_16.png)

---
Видите ли вы новую запись и если да то почему?

*Ответ:* новую запись мы не видим, так как необходимо также завершение транзакции во второй сессии
---

* завершить вторую транзакцию и сделать запрос данных во второй 

![SQL-запрос-12](https://github.com/Kirill67km/sysadmin-homeworks/blob/hometask/postgresql/img/psql_17.png)

---
Видите ли вы новую запись и если да то почему?

*Ответ:* новую запись мы видим, так как новая транзакция будет работать со свежими данными
---