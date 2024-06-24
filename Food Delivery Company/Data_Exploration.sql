-- EXPLORING THE USER TABLE TO GET THE COLUMN NAME 
SELECT * 
FROM USER_INFO 
LIMIT 1;

/* Retrieving list of user information with their name and 
date of registration who uses android phones  */
SELECT 
    NAME, 
    REGISTRATION_DATE, 
    OPERATING_SYSTEM 
FROM 
    USER_INFO 
WHERE 
    OPERATING_SYSTEM = 'ANDROID';

/* finding the users who have registered on or after 
14th of july and sorting the list of users in ascending order */ 
SELECT  
    NAME, 
    REGISTRATION_DATE, 
    OPERATING_SYSTEM 
FROM  
    USER_INFO 
WHERE 
    OPERATING_SYSTEM = 'ANDROID'  
    AND  
    REGISTRATION_DATE >= '2023-07-14'  
ORDER BY 
    NAME ASC;

-- Retrieving all restaurants and their menu items
SELECT 
    R.NAME AS RESTAURANT_NAME, 
    M.NAME AS ITEM_NAME 
FROM 
    RESTAURANT_INFO R 
LEFT JOIN 
    MENUITEMS M  
ON 
    R.RESTAURANT_ID = M.RESTAURANT_ID;

/* Getting the restaurant's contact number and the availability status of each menu item,
If a restaurant does not have any menu items, "No Menu Items" will be displayed. */
SELECT 
    R.NAME AS RESTAURANT_NAME, 
    R.CONTACT_NUMBER, 
    COALESCE(M.NAME, 'No Menu Items') AS ITEM_NAME,  
    M.AVAILABILITY 
FROM 
    RESTAURANT_INFO R 
LEFT JOIN 
    MENUITEMS M  
ON 
    R.RESTAURANT_ID = M.RESTAURANT_ID;

/* -- Retrieving total number of orders per user, displaying user names and total order count 
and sorted in descending order by order count */
SELECT 
    U.NAME AS USER_NAME, 
    COUNT(O.STATUS_ID) AS TOTAL_ORDERS 
FROM 
    USER_INFO AS U 
LEFT JOIN 
    ORDERS AS O 
ON 
    U.ID = O.USER_ID 
    AND O.STATUS_ID = 1  -- Filter completed orders
GROUP BY 
    U.NAME  -- Use U.NAME instead of just NAME
ORDER BY 
    TOTAL_ORDERS DESC;

/* Finding the average price of menu items for each restaurant
and Sort the results in descending order based on the price */
SELECT 
    R.NAME AS RESTAURANT_NAME, 
    ROUND(AVG(M.PRICE), 2) AS AVG_PRICE 
FROM 
    RESTAURANT_INFO AS R 
LEFT JOIN 
    MENUITEMS AS M 
ON 
    R.RESTAURANT_ID = M.RESTAURANT_ID 
GROUP BY 
    RESTAURANT_NAME 
ORDER BY 
    AVG_PRICE DESC;

-- Identifying the restaurant with the highest total sales
SELECT 
    R.NAME AS RESTAURANT_NAME, 
    SUM(O.TOTAL_AMOUNT) AS TOTAL_SALE 
FROM 
    RESTAURANT_INFO AS R 
LEFT JOIN 
    ORDERS AS O 
ON 
    R.RESTAURANT_ID = O.RESTAURANT_ID 
GROUP BY 
    RESTAURANT_NAME 
ORDER BY 
    TOTAL_SALE DESC 
LIMIT 1;

/* Finding the number of orders placed in each city and Sorting
the results in descending order based on the number of orders */
SELECT 
    C.CITY_NAME, 
    COUNT(O.ORDER_ID) AS NUMBER_OF_ORDERS 
FROM 
    CITY AS C 
LEFT JOIN 
    USER_INFO AS U 
ON 
    U.CITY_ID = C.CITY_ID 
LEFT JOIN 
    ORDERS AS O 
ON 
    U.ID = O.USER_ID 
GROUP BY 
    CITY_NAME 
ORDER BY 
    NUMBER_OF_ORDERS DESC;
    
/* Finding the names of restaurants that have at least one menu item
    with a price greater than $10 */
SELECT 
    R.NAME AS RESTAURANT_NAME, 
    M.NAME AS ITEM_NAME, 
    M.PRICE 
FROM 
    RESTAURANT_INFO R 
LEFT JOIN 
    MENUITEMS M 
ON 
    R.RESTAURANT_ID = M.RESTAURANT_ID 
WHERE 
    PRICE > 10
ORDER BY
	PRICE;
    
/* retrieving the user names and their corresponding orders where the 
order total  is greater than the average order total for all users */
SELECT 
    U.NAME AS USER_NAME, 
    O.ORDER_ID, 
    O.TOTAL_AMOUNT 
FROM 
    USER_INFO U 
LEFT JOIN 
    ORDERS O 
ON 
    U.ID = O.USER_ID 
WHERE 
    O.TOTAL_AMOUNT > (
        SELECT 
            AVG(TOTAL_AMOUNT) 
        FROM 
            ORDERS
    );


-- lisingt the names of users whose last names start with 'S' or ends with ‘e’.
SELECT 
    NAME 
FROM 
    USER_INFO 
WHERE  
    LEFT(SUBSTRING_INDEX(NAME, '  ', -1), 1) = 'S'  
    OR  
    RIGHT(SUBSTRING_INDEX(NAME, '  ', -1), 1) = 'e';


/*  finding the total order amounts for each restaurant. 
and using Coalsce if there is Null Value */
SELECT 
    R.NAME AS RESTAURANT_NAME, 
    COALESCE(SUM(O.TOTAL_AMOUNT), 0) AS TOTAL_ORDER_AMOUNT 
FROM 
    RESTAURANT_INFO R 
LEFT JOIN 
    ORDERS O 
ON 
    R.RESTAURANT_ID = O.RESTAURANT_ID 
GROUP BY 
    RESTAURANT_NAME;

 -- finding out how many orders were placed using cash or credit
 SELECT 
    CASE 
        WHEN P.PAY_TYPE_ID = 1 THEN 'CASH'   
        ELSE 'CREDIT'             
    END AS PAYMENT_TYPE, 
    COUNT(O.ORDER_ID) AS ORDER_COUNT 
FROM 
    PAYMENT_TRANSACTIONS P 
LEFT JOIN 
    ORDERS O  
ON 
    O.ORDER_ID = P.ORDER_ID 
GROUP BY 
    PAYMENT_TYPE;

    
