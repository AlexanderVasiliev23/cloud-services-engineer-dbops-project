-- создаем индекс, который поможет нам эффективнее JOINиться с заказами
CREATE INDEX order_product_order_id_idx ON order_product (order_id);

-- создаем композитный индекс для поиска заказов по статусу и дате создания
CREATE INDEX orders_status_date_idx ON orders (status, date_created);