--1.	List the item ID, description, and price for all items.
SELECT ITEM_ID, DESCRIPTION, PRICE FROM ITEM
--2.	List all rows and columns for the complete INVOICES table.
SELECT * FROM INVOICES
--3.	List the first and last names of customers with credit limits of $1,000 or more.
SELECT FIRST_NAME, LAST_NAME FROM CUSTOMER WHERE CREDIT_LIMIT >= 1000;
--4.	List the order number for each order placed by customer number 125 on 11/15/2021. (Hint: If you need help, use the discussion of the DATE data type in Figure 3-19 in Module 3.)
SELECT * FROM INVOICES WHERE CUST_ID = 125 AND INVOICE_DATE = '2021-11-15';
--5.	List the number and name of each customer represented by sales rep 10 or sales rep 15.
SELECT * FROM CUSTOMER WHERE REP_ID = 10 OR REP_ID = 15;
--6.	List the item ID and description of each item that is not in category HOR.
SELECT ITEM_ID, DESCRIPTION FROM ITEM WHERE CATEGORY != 'HOR'
--7.	List the item ID, description, and number of units on hand for each item that has between 10 and 30 units on hand, including both 10 and 30. Provide two alternate SQL statements to produce the same results.
SELECT ITEM_ID,DESCRIPTION,ON_HAND FROM ITEM WHERE ON_HAND BETWEEN 10 AND 30
--8.	List the item ID, description, and on-hand value (units on hand * unit price) of each item in category CAT. (On-hand value is technically units on hand * cost, but there is no COST column in the ITEM table.) Assign the name ON_HAND_VALUE to the computed column.
SELECT ITEM_ID,DESCRIPTION, ON_HAND * PRICE AS ON_HAND_VALUE FROM ITEM WHERE CATEGORY = 'CAT'
--9.	List the item ID, description, and on-hand value for each item where the on-hand value is at least $1,500. Assign the name ON_HAND_VALUE to the computed column.
SELECT ITEM_ID,DESCRIPTION, ON_HAND * PRICE AS ON_HAND_VALUE FROM ITEM WHERE (ON_HAND * PRICE) >= 1500
--10.	Use the IN operator to list the item ID and description of each item in category FSH or BRD.
SELECT ITEM_ID,DESCRIPTION FROM ITEM WHERE CATEGORY IN('FSH', 'BRD')
--11.	Find the ID, first name, and last name of each customer whose first name begins with the letter “S.”
SELECT CUST_ID,FIRST_NAME,LAST_NAME FROM CUSTOMER WHERE FIRST_NAME LIKE 'S%'
--12.	List all details about all items. Order the output by description.
SELECT * FROM ITEM ORDER BY DESCRIPTION
--13.	List all details about all items. Order the output by item ID within location. (That is, order the output by location and then by item ID.)
SELECT * FROM ITEM ORDER BY LOCATION,ITEM_ID
--14.	How many customers have balances that are more than their credit limits?
SELECT COUNT(*) AS CUSTOMERS_OVER_LIMIT FROM CUSTOMER WHERE BALANCE > CREDIT_LIMIT
--15.	Find the total of the balances for all customers represented by sales rep 10 with balances that are less than their credit limits.
SELECT COUNT(BALANCE) FROM CUSTOMER WHERE REP_ID = 10 AND CREDIT_LIMIT > BALANCE
--16.	List the item ID, description, and on-hand value of each item whose number of units on hand is more than the average number of units on hand for all items. (Hint: Use a subquery.)
SELECT ITEM_ID,DESCRIPTION,ON_HAND * PRICE as ON_HAND_VALUE FROM ITEM WHERE (SELECT AVG(ON_HAND) FROM ITEM) > ON_HAND
--17.	What is the price of the least expensive item in the database?
SELECT MIN(PRICE) AS LEAST_EXPENSIVE_ITEM_PRICE FROM ITEM 
--18.	What is the item ID, description, and price of the least expensive item in the database? (Hint: Use a subquery.)
SELECT ITEM_ID,DESCRIPTION,PRICE FROM ITEM WHERE PRICE = (SELECT MIN(PRICE) FROM ITEM)
--19.	List the sum of the balances of all customers for each sales rep. Order and group the results by sales rep ID.
SELECT REP_ID, SUM(BALANCE) AS TOTAL_BALANCE FROM CUSTOMER GROUP BY REP_ID
--20.	List the sum of the balances of all customers for each sales rep but restrict the output to those sales reps for which the sum is more than $150. Order the results by sales rep ID.
SELECT REP_ID, SUM(BALANCE) AS TOTAL_BALANCE FROM CUSTOMER GROUP BY REP_ID HAVING SUM(BALANCE) > 150
--21.	List the item ID of any item with an unknown description.
SELECT ITEM_ID FROM ITEM WHERE DESCRIPTION = NULL
--22.	List the item ID and description of all items that are in the DOG or CAT category and contain the word “Small” in the description.
SELECT ITEM_ID,DESCRIPTION FROM ITEM WHERE CATEGORY IN('DOG', 'CAT') AND DESCRIPTION LIKE('%Small%')
--23.	KimTay Pet Supplies is considering discounting the price of all items by 10 percent. List the item ID, description, and discounted price for all items. Use DISCOUNTED_PRICE as the name for the computed column.
SELECT ITEM_ID,DESCRIPTION,PRICE, PRICE * .9 AS DISCOUNTED_PRICE FROM ITEM