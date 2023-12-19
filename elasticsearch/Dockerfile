# Используем образ Ubuntu
FROM ubuntu:latest

# Обновление списка пакетов и установка необходимых инструментов
RUN apt-get update && apt-get install -y wget gpg ca-certificates

# Установка ключа для репозитория Elasticsearch
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

# Добавление репозитория Elasticsearch
RUN echo "deb [trusted=yes signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://mirror.yandex.ru/mirrors/elastic/7/ stable main" | tee /etc/apt/sources.list.d/elastic-7.x.list

# Обновление списка пакетов и установка Elasticsearch
RUN apt-get update && apt-get install -y elasticsearch


# Копирование конфигурационного файла
COPY elasticsearch.yml /etc/elasticsearch/

# Установка разрешений
RUN chown -R elasticsearch:elasticsearch /etc/elasticsearch

# Установка переменной окружения для имени ноды
ENV node.name=netology_test

# Объявление портов
EXPOSE 9200 9300

# Запуск Elasticsearch
CMD ["elasticsearch"]
