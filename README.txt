The objective of this project is to practice advanced SQL queries using a pre-defined database schema. This exercise focuses on querying, filtering, aggregating, and manipulating data based on real-world business scenarios. The provided schema models a commercial database that includes categories, customers, orders, employees, suppliers, and products. 

 

Description of the database schema :
 

The database is characterized by the following relational schema:

CATEGORIES (CATEGORY_CODE, CATEGORY_NAME, DESCRIPTION)
CUSTOMERS (CUSTOMER_CODE, COMPANY, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
ORDERS (ORDER_NUMBER, CUSTOMER_CODE#, EMPLOYEE_NUMBER#, ORDER_DATE, SHIP_DATE, SHIPPING_COST)
ORDER_DETAILS (ORDER_NUMBER#, PRODUCT_REF#, UNIT_PRICE, QUANTITY, DISCOUNT)
EMPLOYEES (EMPLOYEE_NUMBER, REPORTS_TO#, LAST_NAME, FIRST_NAME, POSITION, TITLE, BIRTH_DATE, HIRE_DATE, SALARY, COMMISSION)
SUPPLIERS (SUPPLIER_NUMBER, COMPANY, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
PRODUCTS (PRODUCT_REF, PRODUCT_NAME, SUPPLIER_NUMBER#, CATEGORY_CODE#, QUANTITY, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, UNAVAILABLE)
Where: 

COMPANY: name of the customer (supplier) company,
SHIPPING_COST: shipping charges,
REPORTS_TO: responsible employee number,
QUANTITY: packaging type (boxes, bottle(s), carton(s), pot(s), glasses, etc.),
UNITS_IN_STOCK: available quantity,
UNITS_ON_ORDER: quantity ordered,
UNAVAILABLE: 0 for available products and -1 otherwise

Instructions:
Write each of the following queries in SQL.

Display in descending order of seniority the male employees whose net salary (salary + commission) is greater than or equal to 8000. The resulting table should include the following columns: Employee Number, First Name and Last Name, Age, and Seniority.
Display products that meet the following criteria: (C1) quantity is packaged in bottle(s), (C2) the third character in the product name is 't' or 'T', (C3) supplied by suppliers 1, 2, or 3, (C4) unit price ranges between 70 and 200, and (C5) units ordered are specified (not null). The resulting table should include the following columns: product number, product name, supplier number, units ordered, and unit price.

Display customers who reside in the same region as supplier 1, meaning they share the same country, city, and the last three digits of the postal code. The query should utilize a single subquery. The resulting table should include all columns from the customer table.

For each order number between 10998 and 11003, do the following:  
Display the new discount rate, which should be 0% if the total order amount before discount (unit price * quantity) is between 0 and 2000, 5% if between 2001 and 10000, 10% if between 10001 and 40000, 15% if between 40001 and 80000, and 20% otherwise.

Display the message "apply old discount rate" if the order number is between 10000 and 10999, and "apply new discount rate" otherwise. The resulting table should display the columns: order number, new discount rate, and discount rate application note.

Display suppliers of beverage products. The resulting table should display the columns: supplier number, company, address, and phone number.

Display customers from Berlin who have ordered at most 1 (0 or 1) dessert product. The resulting table should display the column: customer code.

Display customers who reside in France and the total amount of orders they placed every Monday in April 1998 (considering customers who haven't placed any orders yet). The resulting table should display the columns: customer number, company name, phone number, total amount, and country.

Display customers who have ordered all products. The resulting table should display the columns: customer code, company name, and telephone number.

Display for each customer from France the number of orders they have placed. The resulting table should display the columns: customer code and number of orders.

Display the number of orders placed in 1996, the number of orders placed in 1997, and the difference between these two numbers. The resulting table should display the columns: orders in 1996, orders in 1997, and Difference.
