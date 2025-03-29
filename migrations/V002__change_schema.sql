-- добавляем поле цены для товаров
ALTER TABLE product
    ADD COLUMN price DOUBLE PRECISION;

-- делаем id товара первичным ключем
ALTER TABLE product
    ADD PRIMARY KEY (id);

-- добавляем поле с датой создания заказа
ALTER TABLE orders
    ADD COLUMN date_created DATE DEFAULT CURRENT_DATE;

-- делаем id заказа первичным ключем
ALTER TABLE orders
    ADD PRIMARY KEY (id);

-- удаляем таблицу product_info (единственное полезное поле price было перенесено в таблицу product)
DROP TABLE product_info;

-- удаляем таблицу orders_date (единственное полезное поле date_created было перенесено в таблицу orders)
DROP TABLE orders_date;

-- добавляем внешний ключ, ссылающийся на таблицу товаров
ALTER TABLE order_product
    ADD CONSTRAINT fk_order_product_product_id
        FOREIGN KEY (product_id) REFERENCES product (id);

-- добавляем внешний ключ, ссылающийся на таблицу заказов
ALTER TABLE order_product
    ADD CONSTRAINT fk_order_product_orders_id
        FOREIGN KEY (order_id) REFERENCES orders (id);
