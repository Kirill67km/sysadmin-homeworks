# Домашнее задание к занятию «Микросервисы: подходы»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.


## Задача 1: Обеспечить разработку

Предложите решение для обеспечения процесса разработки: хранение исходного кода, непрерывная интеграция и непрерывная поставка. 
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- облачная система;
- система контроля версий Git;
- репозиторий на каждый сервис;
- запуск сборки по событию из системы контроля версий;
- запуск сборки по кнопке с указанием параметров;
- возможность привязать настройки к каждой сборке;
- возможность создания шаблонов для различных конфигураций сборок;
- возможность безопасного хранения секретных данных (пароли, ключи доступа);
- несколько конфигураций для сборки из одного репозитория;
- кастомные шаги при сборке;
- собственные докер-образы для сборки проектов;
- возможность развернуть агентов сборки на собственных серверах;
- возможность параллельного запуска нескольких сборок;
- возможность параллельного запуска тестов.

Обоснуйте свой выбор.

### Решение для обеспечения процесса разработки

Для обеспечения процесса разработки, включая хранение исходного кода, непрерывную интеграцию и непрерывную поставку, предлагаю использовать комбинацию следующих облачных сервисов и инструментов:

### 1. GitHub
GitHub является облачной системой управления версиями на основе Git, которая обеспечивает хранение исходного кода и управление версиями.

#### Причины выбора:
- Облачное решение.
- Поддержка системы контроля версий Git.
- Репозиторий на каждый сервис.
- Веб-хуки для запуска CI/CD процессов.
- Возможность создания шаблонов для различных конфигураций сборок (GitHub Actions).

### 2. Jenkins
Jenkins — это инструмент для автоматизации, который обеспечивает непрерывную интеграцию и непрерывную доставку. Он поддерживает различные плагины для интеграции с другими инструментами и сервисами.

#### Причины выбора:
- Запуск сборки по событию из системы контроля версий.
- Запуск сборки по кнопке с указанием параметров.
- Возможность привязать настройки к каждой сборке.
- Возможность создания шаблонов для различных конфигураций сборок.
- Безопасное хранение секретных данных (пароли, ключи доступа) с использованием Jenkins Credentials.
- Несколько конфигураций для сборки из одного репозитория.
- Кастомные шаги при сборке.
- Поддержка собственных докер-образов для сборки проектов.
- Возможность развернуть агентов сборки на собственных серверах.
- Возможность параллельного запуска нескольких сборок и тестов.

### 3. Docker Hub или GitHub Container Registry
Эти сервисы позволяют хранить и управлять Docker-образами.

#### Причины выбора:
- Хранение и управление собственными докер-образами.
- Интеграция с Jenkins для использования Docker-образов при сборке.

### 4. Self-hosted Runners (Самостоятельные агенты сборки) для Jenkins
Jenkins поддерживает self-hosted runners (агенты), которые могут быть развернуты на собственных серверах.

#### Причины выбора:
- Возможность развернуть агентов сборки на собственных серверах для выполнения сборок и тестов.
- Оптимизация затрат на сборку.
- Контроль над средой выполнения сборок.

### Безопасность и управление секретами:
- Используйте Jenkins Credentials для безопасного хранения паролей, токенов и других конфиденциальных данных.
- Гранулярный доступ к секретам для разных джобов и рабочих процессов.

### Параллельное выполнение:
- Jenkins поддерживает параллельное выполнение джобов и шагов в пайплайне.
- Возможность определения зависимостей между заданиями и параллельного выполнения заданий без зависимостей.

### Обоснование:
Эти инструменты и сервисы предоставляют полный набор возможностей для реализации процесса разработки, соответствующего всем требованиям. GitHub в сочетании с Jenkins и Docker Hub/GitHub Container Registry обеспечивает гибкость, безопасность и масштабируемость для CI/CD процессов, а также удобное управление исходным кодом и конфигурациями сборок.

## Задача 2: Логи

Предложите решение для обеспечения сбора и анализа логов сервисов в микросервисной архитектуре.
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- сбор логов в центральное хранилище со всех хостов, обслуживающих систему;
- минимальные требования к приложениям, сбор логов из stdout;
- гарантированная доставка логов до центрального хранилища;
- обеспечение поиска и фильтрации по записям логов;
- обеспечение пользовательского интерфейса с возможностью предоставления доступа разработчикам для поиска по записям логов;
- возможность дать ссылку на сохранённый поиск по записям логов.

Обоснуйте свой выбор.

### Решение для сбора и анализа логов в микросервисной архитектуре

Для обеспечения сбора и анализа логов в микросервисной архитектуре предлагаю использовать стек ELK (Elasticsearch, Logstash, Kibana) с дополнением Beats. Этот стек обеспечивает все необходимые функциональности для централизованного сбора, обработки, хранения и анализа логов.

#### Архитектура решения

1. Beats:
   - Filebeat: Легковесный агент для пересылки и централизации логов. Устанавливается на каждом хосте и собирает логи из stdout.
   - Heartbeat: Мониторинг доступности сервисов.
   - Metricbeat: Сбор метрик системы.

2. Logstash:
   - Отвечает за сбор, обработку и преобразование логов перед их отправкой в Elasticsearch.
   - Позволяет гарантировать доставку логов с использованием буферизации и механизмов повторной отправки.

3. Elasticsearch:
   - Высокопроизводительная поисковая система, которая хранит логи и обеспечивает быстрый поиск и фильтрацию данных.

4. Kibana:
   - Веб-интерфейс для визуализации и анализа логов.
   - Обеспечивает возможности построения дашбордов, сохранения и предоставления ссылок на сохранённые поисковые запросы.

#### Принципы взаимодействия

1. Сбор логов (Beats):
   - Filebeat установлен на каждом хосте и собирает логи из stdout микросервисов.
   - Логи отправляются в Logstash для дальнейшей обработки.

2. Обработка логов (Logstash):
   - Logstash принимает логи от Filebeat.
   - Применяются фильтры для разбора, преобразования и обогащения логов.
   - Гарантированная доставка логов обеспечивается за счет механизмов обработки ошибок и повторной отправки.

3. Хранение и поиск (Elasticsearch):
   - Обработанные логи отправляются в Elasticsearch для хранения.
   - Elasticsearch обеспечивает возможность быстрого поиска и фильтрации данных.

4. Анализ и визуализация (Kibana):
   - Kibana подключается к Elasticsearch и предоставляет веб-интерфейс для анализа логов.
   - Разработчики могут искать и фильтровать логи, создавать дашборды и сохранять поисковые запросы.
   - Kibana позволяет создавать ссылки на сохранённые поисковые запросы для удобного доступа и совместного использования.

#### Обоснование выбора

- Централизованное хранилище: Elasticsearch обеспечивает централизованное хранение логов с возможностью масштабирования.
- Минимальные требования к приложениям: Использование Filebeat для сбора логов из stdout минимизирует требования к изменениям в приложениях.
- Гарантированная доставка логов: Logstash обеспечивает надежную обработку и доставку логов с помощью механизмов повторной отправки.
- Поиск и фильтрация: Elasticsearch предоставляет мощные возможности для поиска и фильтрации данных, а Kibana обеспечивает удобный интерфейс для работы с логами.
- Пользовательский интерфейс: Kibana позволяет разработчикам легко искать и анализировать логи, а также предоставляет возможность сохранять и делиться поисковыми запросами.

#### Схема взаимодействия компонентов
[Микросервисы] -> [Filebeat] -> [Logstash] -> [Elasticsearch] -> [Kibana]

Это решение удовлетворяет всем требованиям и обеспечивает надежный и масштабируемый подход к сбору и анализу логов в микросервисной архитектуре.

## Задача 3: Мониторинг

Предложите решение для обеспечения сбора и анализа состояния хостов и сервисов в микросервисной архитектуре.
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- сбор метрик со всех хостов, обслуживающих систему;
- сбор метрик состояния ресурсов хостов: CPU, RAM, HDD, Network;
- сбор метрик потребляемых ресурсов для каждого сервиса: CPU, RAM, HDD, Network;
- сбор метрик, специфичных для каждого сервиса;
- пользовательский интерфейс с возможностью делать запросы и агрегировать информацию;
- пользовательский интерфейс с возможностью настраивать различные панели для отслеживания состояния системы.

Обоснуйте свой выбор.

### Решение для сбора и анализа состояния хостов и сервисов

Предлагаю использовать стек Prometheus + Grafana для мониторинга и визуализации метрик в микросервисной архитектуре.

#### Компоненты

1. Prometheus
   - Сбор и хранение метрик.
   - Поддержка языка запросов PromQL для анализа данных.

2. Node Exporter
   - Сбор системных метрик хостов (CPU, RAM, HDD, Network).
   - Устанавливается на каждом хосте.

3. cAdvisor
   - Мониторинг ресурсов контейнеров (CPU, RAM, HDD, Network).

4. Custom Exporters
   - Сбор специфичных метрик для каждого сервиса.

5. Grafana
   - Визуализация метрик.
   - Создание настраиваемых панелей и дашбордов.

#### Взаимодействие

1. Сбор метрик
   - Node Exporter собирает системные метрики хостов.
   - cAdvisor собирает метрики контейнеров.
   - Custom Exporters собирают специфичные метрики сервисов.

2. Мониторинг и оповещение
   - Prometheus периодически опрашивает экспортеры для сбора метрик.
   - Настройка правил оповещения в Prometheus.

3. Анализ и визуализация
   - Grafana подключается к Prometheus для визуализации метрик.
   - Создание и настройка дашбордов в Grafana.

#### Обоснование

- Сбор метрик: Node Exporter и cAdvisor обеспечивают сбор системных и контейнерных метрик.
- Специфичные метрики: Custom Exporters для специфичных данных.
- Визуализация: Grafana предоставляет мощный интерфейс для анализа данных.
- Масштабируемость и надежность: Prometheus и Grafana широко используются в индустрии и обеспечивают надежное решение.

#### Схема
[Хосты с Node Exporter] -> [Prometheus]
[Контейнеры с cAdvisor] -> [Prometheus]
[Сервисы с Custom Exporters] -> [Prometheus]

Prometheus -> Grafana

## Задача 4: Логи * (необязательная)

Продолжить работу по задаче API Gateway: сервисы, используемые в задаче, пишут логи в stdout. 

Добавить в систему сервисы для сбора логов Vector + ElasticSearch + Kibana со всех сервисов, обеспечивающих работу API.

### Результат выполнения: 

docker compose файл, запустив который можно перейти по адресу http://localhost:8081, по которому доступна Kibana.
Логин в Kibana должен быть admin, пароль qwerty123456.


## Задача 5: Мониторинг * (необязательная)

Продолжить работу по задаче API Gateway: сервисы, используемые в задаче, предоставляют набор метрик в формате prometheus:

- сервис security по адресу /metrics,
- сервис uploader по адресу /metrics,
- сервис storage (minio) по адресу /minio/v2/metrics/cluster.

Добавить в систему сервисы для сбора метрик (Prometheus и Grafana) со всех сервисов, обеспечивающих работу API.
Построить в Graphana dashboard, показывающий распределение запросов по сервисам.

### Результат выполнения: 

docker compose файл, запустив который можно перейти по адресу http://localhost:8081, по которому доступна Grafana с настроенным Dashboard.
Логин в Grafana должен быть admin, пароль qwerty123456.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
