# Создание нового пользователя

Для работы с новой базой данных `store` создадим нового пользователя.
Назовем его `store_user`. Дадим ему все права на все таблицы в базе `store`, так как под этим пользователем мы будем выполнять автотесты и миграции.

- на сервере заходим в контейнер (postgres запущен в docker)
```
docker exec -it postgres bash
```

- внутри контейнера подключаемся к базе данных (дефольный пользователь из docker-compose файла)
```
psql -U user -d store
```

- создаем нового пользователя `store_user` с паролем `secret_password`
```sql
CREATE ROLE store_user WITH LOGIN PASSWORD 'secret_password';
```

- выдаём доступ ко всем привилегиям новому сервисному пользователю
```sql
-- доступ к схеме public
GRANT ALL PRIVILEGES ON SCHEMA public TO store_user;

-- доступ ко всем существующим таблицам
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO store_user;

-- доступ к таблицам, созданным в будущем
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO store_user;
```

# Запрос на получение кол-ва проданных сосисок за последние 7 дней с разбивкой по дням

```sql
SELECT o.date_created, SUM(op.quantity)
FROM orders AS o
         JOIN order_product AS op ON o.id = op.order_id
WHERE status = 'shipped'
  AND o.date_created > NOW() - INTERVAL '7 DAY'
GROUP BY o.date_created
;
```