-- Get all customers and their addresses.

SELECT * FROM "customers"
JOIN "addresses" ON "customers"."id" = "addresses"."customer_id";

-- Get all orders and their line items (orders, quantity and product).

SELECT "line_items"."order_id", "orders"."order_date", "line_items"."quantity", "products"."description" FROM "orders"
JOIN "line_items" ON "orders"."id" = "line_items"."order_id"
JOIN "products" ON "line_items"."product_id" = "products"."id";

-- Which warehouses have cheetos?

SELECT "warehouse"."id", "warehouse"."warehouse", "products"."description", "warehouse_product"."on_hand" FROM "warehouse_product"
JOIN "warehouse" ON "warehouse"."id" = "warehouse_product"."warehouse_id"
JOIN "products" ON "products"."id" = "warehouse_product"."product_id"
WHERE "products"."description" = 'cheetos'
;

-- Which warehouses have diet pepsi?

SELECT "warehouse"."id", "warehouse"."warehouse", "products"."description", "warehouse_product"."on_hand" FROM "warehouse_product"
JOIN "warehouse" ON "warehouse"."id" = "warehouse_product"."warehouse_id"
JOIN "products" ON "products"."id" = "warehouse_product"."product_id"
WHERE "products"."description" = 'diet pepsi'
;

-- Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.

SELECT "customers"."id", "customers"."first_name", "customers"."last_name", COUNT("customers"."id") FROM "customers"
JOIN "addresses" ON "addresses"."customer_id" = "customers"."id"
JOIN "orders" ON "orders"."address_id" = "addresses"."id"
GROUP BY "customers"."id"
;

-- How many customers do we have?

SELECT COUNT("customers"."id") FROM "customers";

-- How many products do we carry?

SELECT COUNT("products"."id") FROM "products";

-- What is the total available on-hand quantity of diet pepsi?

SELECT "products"."description", SUM("warehouse_product"."on_hand") FROM "warehouse_product"
JOIN "products" ON "products"."id" = "warehouse_product"."product_id"
WHERE "products"."description" = 'diet pepsi'
GROUP BY "products"."description";


------ STRETCH -------

--9.	How much was the total cost for each order?

SELECT "line_items"."order_id", SUM("products"."unit_price" * "line_items"."quantity") FROM "orders"
JOIN "line_items" ON "orders"."id" = "line_items"."order_id"
JOIN "products" ON "line_items"."product_id" = "products"."id"
GROUP BY "line_items"."order_id";