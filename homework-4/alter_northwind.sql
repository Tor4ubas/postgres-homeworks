-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
ALTER TABLE products ADD CONSTRAINT unit_price_check CHECK (unit_price > 0);

SELECT * FROM products;

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
ALTER TABLE products ADD CONSTRAINT discontinued_check CHECK (discontinued IN (0, 1));

SELECT * FROM products;

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
CREATE TABLE other_products AS
SELECT * FROM products WHERE discontinued = 1;

SELECT * FROM other_products;

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта не требуется удаление ограничения внешнего ключа, чтобы сохранить связь с таблицей order_details

-- Удаляем из products товары с discontinued = 1
DELETE FROM products WHERE discontinued = 1;

SELECT * FROM products;

-- 5. Восстановить ограничение внешнего ключа в таблице order_details
ALTER TABLE order_details
    ADD CONSTRAINT fk_order_details_products FOREIGN KEY (product_id)
    REFERENCES products (product_id);