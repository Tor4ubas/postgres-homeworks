"""Скрипт для заполнения данными таблиц в БД Postgres."""

import psycopg2
import os
import csv

create_tables = 'create_tables.sql'
employees = os.path.abspath('north_data/employees_data.csv')
orders = os.path.abspath('north_data/orders_data.csv')
customers = os.path.abspath('north_data/customers_data.csv')

# connect to db
conn = psycopg2.connect(host='localhost', database='north', user='postgres', password='alfa_11')

def main():
    try:
        with conn:
            with conn.cursor() as cursor:
                # execute query
                cursor.execute(open(create_tables, 'r').read())
                #cursor.execute("DROP TABLE IF EXISTS employees")

                # Заполнение таблицы сотрудников
                with open(employees, 'r', encoding='utf8') as file:
                    info = csv.reader(file, delimiter=",")
                    count = 0
                    for row in info:
                        if count == 0:
                            count += 1
                            continue
                        else:
                            cursor.execute("INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)",
                                           (int(row[0]), row[1], row[2], row[3], row[4], row[5]))
                            conn.commit()

                # Заполнение таблицы клиентов
                with open(customers, 'r', encoding='utf8') as file:
                    info = csv.reader(file, delimiter=",")
                    count = 0
                    for row in info:
                        if count == 0:
                            count += 1
                            continue
                        else:
                            try:
                                cursor.execute("INSERT INTO customers VALUES (%s, %s, %s)",
                                               (row[0], row[1], row[2]))
                                conn.commit()
                            except psycopg2.DatabaseError as e:
                                conn.rollback()
                                print("Error:", e)
                                continue

                # Заполнение таблицы заказов
                with open(orders, 'r', encoding='utf8') as file:
                    info = csv.reader(file, delimiter=",")
                    count = 0
                    for row in info:
                        if count == 0:
                            count += 1
                            continue
                        else:
                            try:
                                cursor.execute("INSERT INTO orders (order_id, customer_id, employee_id, order_date, ship_city)"
                                              " VALUES (%s, %s, %s, %s, %s)", (int(row[0]), row[1], int(row[2]), row[3], row[4]))
                                conn.commit()
                            except psycopg2.DatabaseError as e:
                                conn.rollback()
                                print("Error:", e)
                                continue
    finally:
        # close connection
        conn.close()

if __name__ == "__main__":
    main()