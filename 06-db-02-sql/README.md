# Домашнее задание к занятию 2. «SQL»

## Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.Приведите получившуюся команду или docker-compose-манифест.

[docker-compose](https://github.com/Kirill67km/sysadmin-homeworks/blob/main/06-db-02-sql/docker-compose.yml)

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db;
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже);
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db;
- создайте пользователя test-simple-user;
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE этих таблиц БД test_db.



Таблица orders:
- id (serial primary key);
- наименование (string);
- цена (integer).
  
Таблица clients:
- id (serial primary key);
- фамилия (string);
- страна проживания (string, index);- заказ (foreign key orders).

Приведите:
- итоговый список БД после выполнения пунктов выше;

```sql
\l
```

- описание таблиц (describe);

```sql
\d orders
```

- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db;

```sql
SELECT table_catalog, table_schema, table_name, grantee, privilege_type
FROM information_schema.table_privileges
WHERE table_schema = 'public' AND table_name IN ('orders', 'clients');
```

- список пользователей с правами над таблицами test_db

```sql
\dp orders
\dp clients
```

## Задача 3
Используя SQL-синтаксис, наполните таблицы следующими тестовыми данными:

Таблица orders
|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

```sql
INSERT INTO orders (name, price) VALUES
  ('Шоколад', 10),
  ('Принтер', 3000),
  ('Книга', 500),
  ('Монитор', 7000),
  ('Гитара', 4000);
```

Таблица clients
|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

```sql
INSERT INTO clients (surname, country) VALUES
  ('Иванов Иван Иванович', 'Canada'),
  ('Петров Петр Петрович', 'Russia'),
  ('Иоганн Себастьян Бах', 'Japan'),
  ('Ронни Джеймс Дио', 'Russia'),
  ('Ritchie Blackmore', 'Russia');
```

Используя SQL-синтаксис:- вычислите количество записей для каждой таблицы.

```sql
-- Для таблицы orders
SELECT COUNT(*) FROM orders;

-- Для таблицы clients
SELECT COUNT(*) FROM clients;
```

Приведите в ответе:    
- запросы,
- результаты их выполнения.

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.
Используя foreign keys, свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения этих операций.
Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод этого запроса. 
Подсказка: используйте директиву `UPDATE`.

```sql
-- Создание внешнего ключа в таблице clients, который ссылается на таблицу orders
ALTER TABLE clients ADD FOREIGN KEY (order_id) REFERENCES orders(id); 

--Обновление данных
UPDATE clients SET order_id = (SELECT id FROM orders WHERE name = 'Книга') WHERE surname = 'Иванов Иван Иванович';
UPDATE clients SET order_id = (SELECT id FROM orders WHERE name = 'Монитор') WHERE surname= 'Петров Петр Петрович'; UPDATE clients SET order_id = (SELECT id FROM orders WHERE name = 'Гитара') WHERE surname = 'Иоганн Себастьян Бах';

-- Выдача всех пользователей, которые совершали заказ
SELECT clients.id, clients.last_name, clients.first_name, clients.patronymic, orders.name as order_name
FROM clients
JOIN orders ON clients.order_id = orders.id
WHERE clients.order_id IS NOT NULL;
```

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN).
Приведите получившийся результат и объясните, что значат полученные значения.

```sql
explain SELECT clients.id, clients.surname, orders.name as order_name
FROM clients
JOIN orders ON clients.order_id = orders.id
WHERE clients.order_id IS NOT NULL;
                              QUERY PLAN                               
-----------------------------------------------------------------------
 Hash Join  (cost=11.57..24.20 rows=70 width=1036)
   Hash Cond: (orders.id = clients.order_id)
   ->  Seq Scan on orders  (cost=0.00..11.40 rows=140 width=520)
   ->  Hash  (cost=10.70..10.70 rows=70 width=524)
         ->  Seq Scan on clients  (cost=0.00..10.70 rows=70 width=524)
               Filter: (order_id IS NOT NULL)
(6 rows)
```
Explain сообщает, что выполняется последовательное чтение данных из таблицы clients. 
Сosts показывает затратность операции, 0.00 первая строка, 15.88 всех строк. Единицой измерения является стоимость чтения объема данных (8KB) при последовательном чтении.
Rows показывает количество строк.
Width показывает средний размер одной строки в байтах.

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. задачу 1).
Остановите контейнер с PostgreSQL, но не удаляйте volumes. 
Поднимите новый пустой контейнер с PostgreSQL.
Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления.

```bash
-- Backup данных
docker exec -t postgres-container pg_dumpall -c -U test_admin_user > /backups/backup.sql

-- Остановите контейнер с PostgreSQL, но не удаляйте volumes
docker stop postgres-container

-- Поднимите новый пустой контейнер с PostgreSQL
docker run --name postgres-container-2 -v ./data:/var/lib/postgresql/data -v ./backups:/backups -e POSTGRES_PASSWORD=1q2w3e4r -d test_db

-- Восстановите БД test_db в новом контейнере
cat ./backups/backup.sql | docker exec -i postgres-container-2 psql -U test_admin_user
```

