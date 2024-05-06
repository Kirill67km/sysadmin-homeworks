# Домашнее задание к занятию 4. «PostgreSQL»

## Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.
Подключитесь к БД PostgreSQL, используя `psql`.
Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД,

```sql
\l
```

- подключения к БД,

```sql
\c <database>
```

- вывода списка таблиц,

```sql
\dt
```

- вывода описания содержимого таблиц,

```sql
\d <table>
```

- выхода из psql.

```sql
\q
```

## Задача 2

Используя `psql`, создайте БД `test_database`.

```sql
CREATE DATABASE test_database;
```

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

```bash
-- Выдаю максимальные права на дамп
chmod 777 ./06-db-04-postgresql/test_data/backups/test_dump.sql

-- Подключась к контейнеру
sudo docker exec -ti postgres bash

-- Восстанавливаю дамп
psql -U test_admin_user -d test_database < ./test_dump.sql
```

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

```sql
ANALYZE VERBOSE ORDERS;
```

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` с наибольшим средним значением размера элементов в байтах.

```sql
SELECT avg_width, attname
FROM pg_stats
WHERE tablename = 'orders'
ORDER BY avg_width desc
LIMIT 1;

--title
```

**Приведите в ответе** команду, которую вы использовали для вычисления, и полученный результат.

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров ипоиск по ней занимает долгое время. Вам как успешному выпускнику курсов DevOps в Нетологии предложилипровести разбиение таблицы на 2: 
шардировать на orders_1 - price>499 и orders_2 - price<=499.

Предложите SQL-транзакцию для проведения этой операции.

```sql
CREATE TABLE orders_1 PARTITION OF orders FOR VALUES FROM (499) TO (MAXVALUE);
CREATE TABLE orders_2 PARTITION OF orders_2 FOR VALUES FROM (MINVALUE) TO (499);
```

Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?

- Можно было бы исключить, если бы изначально была бы создана партицированная таблица 


## Задача 4

Используя утилиту `pg_dump`, создайте бекап БД `test_database`.

```sql
pg_dump test_database > test_dump2.sql
```

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

```sql
ALTER TABLE public.orders_1 ADD UNIQUE (title);
ALTER TABLE public.orders_2 ADD UNIQUE (title);
```
