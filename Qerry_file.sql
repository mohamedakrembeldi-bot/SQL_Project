use Project;

-- question 3
select 
EMPLOYEE_int as "EMPLOYEE_NUMBER",
FIRST_NAME, LAST_NAME,
YEAR(GETDATE()) - YEAR(BIRTH_DATE)  as "Age",
YEAR(GETDATE()) - YEAR(HIRE_DATE) as "Seniority",
(SALARY + ISNULL(COMMISSION, 0)) as "Net Salary"
from EMPLOYEES    
where 
SALARY + ISNULL(COMMISSION, 0) >= 8000
order by  Seniority DESC;
   
-- question 4
select 
PRODUCT_REF as [Product Number], 
PRODUCT_NAME as [Product Name], 
SUPPLIER_int as [Supplier Number], 
UNITS_ON_ORDER as [Units Ordered], 
UNIT_PRICE as [Unit Price]
from PRODUCTS
where 
-- (C1) Quantity is packaged in bottle(s)
(QUANTITY like '%bottle%' or QUANTITY like '%bottles%')
    
 -- (C2) Third character in product name is 't' or 'T'
    and PRODUCT_NAME like '__[tT]%'
    
-- (C3) Supplied by suppliers 1, 2, or 3
and SUPPLIER_int in (1, 2, 3)
    
-- (C4) Unit price ranges between 70 and 200
and UNIT_PRICE between 70 and 200
    
-- (C5) Units ordered are specified (not null)
and UNITS_ON_ORDER is not null;


--Question 5
select *
from CUSTOMERS
where COUNTRY + CITY  + right(POSTAL_CODE, 3) = (
    select COUNTRY + CITY + right(POSTAL_CODE, 3)
    from SUPPLIERS
    where SUPPLIER_int = 1
);

--Qestion 6
SELECT 
    ORDER_int,
    CASE 
        WHEN SUM(UNIT_PRICE * QUANTITY) BETWEEN 0 AND 2000 THEN '0%'
        WHEN SUM(UNIT_PRICE * QUANTITY) BETWEEN 2001 AND 10000 THEN '5%'
        WHEN SUM(UNIT_PRICE * QUANTITY) BETWEEN 10001 AND 40000 THEN '10%'
        WHEN SUM(UNIT_PRICE * QUANTITY) BETWEEN 40001 AND 80000 THEN '15%'
        ELSE '20%'
    END AS [New Discount Rate],
    CASE 
        WHEN ORDER_int BETWEEN 10000 AND 10999 THEN 'apply old discount rate'
        ELSE 'apply new discount rate'
    END AS [Discount Rate Application Note]
FROM ORDER_DETAILS
WHERE ORDER_int BETWEEN 10998 AND 11003
GROUP BY ORDER_int;

--Qestion 7
SELECT DISTINCT 
    S.SUPPLIER_int, 
    S.COMPANY, 
    S.ADDRESS, 
    S.PHONE
FROM SUPPLIERS S
JOIN PRODUCTS P ON S.SUPPLIER_int = P.SUPPLIER_int
JOIN CATEGORIES C ON P.CATEGORY_CODE = C.CATEGORY_CODE
WHERE C.CATEGORY_NAME = 'Beverages';

--Qestion 8
SELECT C.CUSTOMER_CODE
FROM CUSTOMERS C
LEFT JOIN ORDERS O ON C.CUSTOMER_CODE = O.CUSTOMER_CODE
LEFT JOIN ORDER_DETAILS OD ON O.ORDER_int = OD.ORDER_int
LEFT JOIN PRODUCTS P ON OD.PRODUCT_REF = P.PRODUCT_REF
LEFT JOIN CATEGORIES CAT ON P.CATEGORY_CODE = CAT.CATEGORY_CODE 
    AND CAT.CATEGORY_NAME = 'Desserts'
WHERE C.CITY = 'Berlin'
GROUP BY C.CUSTOMER_CODE
HAVING COUNT(DISTINCT P.PRODUCT_REF) <= 1;

--Qestion 9
SELECT 
    C.CUSTOMER_CODE AS [Customer Number], 
    C.COMPANY AS [Company Name], 
    C.PHONE AS [Phone Number], 
    SUM(ISNULL(OD.UNIT_PRICE * OD.QUANTITY, 0)) AS [Total Amount], 
    C.COUNTRY
FROM CUSTOMERS C
LEFT JOIN ORDERS O ON C.CUSTOMER_CODE = O.CUSTOMER_CODE 
    AND YEAR(O.ORDER_DATE) = 1998 
    AND MONTH(O.ORDER_DATE) = 4
    AND DATEPART(WEEKDAY, O.ORDER_DATE) = 2 -- 2 represents Monday in standard SQL Server settings
LEFT JOIN ORDER_DETAILS OD ON O.ORDER_int = OD.ORDER_int
WHERE C.COUNTRY = 'France'
GROUP BY C.CUSTOMER_CODE, C.COMPANY, C.PHONE, C.COUNTRY;

--Qestion 10
SELECT 
    CUSTOMER_CODE, 
    COMPANY, 
    PHONE
FROM CUSTOMERS C
WHERE NOT EXISTS (
    -- Get the set of all products
    SELECT PRODUCT_REF 
    FROM PRODUCTS
    
    EXCEPT
    
    -- Get the set of products this specific customer has ordered
    SELECT OD.PRODUCT_REF
    FROM ORDER_DETAILS OD
    JOIN ORDERS O ON OD.ORDER_int = O.ORDER_int
    WHERE O.CUSTOMER_CODE = C.CUSTOMER_CODE
);

--Qestion 11
SELECT 
    C.CUSTOMER_CODE, 
    COUNT(O.ORDER_int) AS [Number of Orders]
FROM CUSTOMERS C
LEFT JOIN ORDERS O ON C.CUSTOMER_CODE = O.CUSTOMER_CODE
WHERE C.COUNTRY = 'France'
GROUP BY C.CUSTOMER_CODE;

--Qestion 12
SELECT 
    SUM(CASE WHEN YEAR(ORDER_DATE) = 1996 THEN 1 ELSE 0 END) AS [orders in 1996],
    SUM(CASE WHEN YEAR(ORDER_DATE) = 1997 THEN 1 ELSE 0 END) AS [orders in 1997],
    SUM(CASE WHEN YEAR(ORDER_DATE) = 1997 THEN 1 ELSE 0 END) - 
    SUM(CASE WHEN YEAR(ORDER_DATE) = 1996 THEN 1 ELSE 0 END) AS Difference
FROM ORDERS;