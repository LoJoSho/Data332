--1.	For each invoice, list the invoice number and invoice date along with the ID, first name, and last name of the customer for which the invoice was created.
SELECT INVOICES.INVOICE_NUM, INVOICES.INVOICE_DATE, INVOICES.CUST_ID, CUSTOMER.FIRST_NAME, CUSTOMER.LAST_NAME
FROM INVOICE_LINE, INVOICES, CUSTOMER
WHERE INVOICE_LINE.INVOICE_NUM = INVOICES.INVOICE_NUM AND INVOICES.CUST_ID = CUSTOMER.CUST_ID
--2.	For each invoice placed on November 15, 2021, list the invoice number along with the ID, first name, and last name of the customer for which the invoice was created.
SELECT INVOICES.INVOICE_NUM, CUSTOMER.CUST_ID, CUSTOMER.FIRST_NAME, CUSTOMER.LAST_NAME
FROM INVOICES, CUSTOMER
WHERE INVOICES.INVOICE_DATE = '11-15-2021' AND INVOICES.CUST_ID = CUSTOMER.CUST_ID
--3.	For each invoice, list the invoice number, invoice date, item ID, quantity ordered, and quoted price for each invoice line that makes up the invoice.
SELECT INVOICES.INVOICE_NUM, INVOICES.INVOICE_DATE, INVOICE_LINE.ITEM_ID, INVOICE_LINE.QUANTITY, INVOICE_LINE.QUOTED_PRICE FROM INVOICE_LINE, INVOICES WHERE INVOICE_LINE.INVOICE_NUM = INVOICES.INVOICE_NUM
--4.	Use the IN operator to find the ID, first name, and last name of each customer for which an invoice was created on November 15, 2021.
SELECT CUST_ID,FIRST_NAME,LAST_NAME FROM CUSTOMER WHERE CUSTOMER.CUST_ID IN(SELECT CUST_ID FROM INVOICES WHERE INVOICES.INVOICE_DATE = '11-15-2021')
--5.	Find the ID, first name, and last name of each customer for which an invoice was not created on November 15, 2021.
SELECT CUST_ID,FIRST_NAME,LAST_NAME FROM CUSTOMER WHERE CUSTOMER.CUST_ID IN(SELECT CUST_ID FROM INVOICES WHERE INVOICES.INVOICE_DATE = '11-15-2021')
--6.	For each invoice, list the invoice number, invoice date, item ID, description, and category for each item that makes up the invoice.
SELECT INVOICES.INVOICE_NUM,INVOICES.INVOICE_DATE,INVOICE_LINE.ITEM_ID, ITEM.DESCRIPTION, ITEM.CATEGORY FROM INVOICES, INVOICE_LINE, CUSTOMER, ITEM WHERE INVOICES.INVOICE_NUM = INVOICE_LINE.INVOICE_NUM AND INVOICE_LINE.ITEM_ID = ITEM.ITEM_ID
--7.	Find the ID, first name, and last name of each customer that currently has an invoice on file for Wild Bird Food (25 lb).
SELECT CUSTOMER.CUST_ID, CUSTOMER.FIRST_NAME, CUSTOMER.LAST_NAME FROM INVOICE_LINE, INVOICES, ITEM, CUSTOMER WHERE INVOICES.INVOICE_NUM = INVOICE_LINE.INVOICE_NUM AND INVOICES.CUST_ID = CUSTOMER.CUST_ID AND INVOICE_LINE.ITEM_ID = ITEM.ITEM_ID AND ITEM.DESCRIPTION LIKE('%Wild Bird Food%')
--8.	List the item ID, description, and category for each pair of items that are in the same category. (For example, one such pair would be item FS42 and item PF19, because the category for both items is FSH.)
SELECT * FROM ITEM ia, ITEM ib WHERE ia.CATEGORY = ib.CATEGORY order by ia.CATEGORY, ib.CATEGORY 
--9.	List the invoice number and invoice date for each invoice created for the customer James Gonzalez.
SELECT INVOICES.INVOICE_NUM, INVOICES.INVOICE_DATE FROM INVOICES, CUSTOMER WHERE INVOICES.CUST_ID = CUSTOMER.CUST_ID AND CUSTOMER.FIRST_NAME = 'James' AND CUSTOMER.LAST_NAME = 'Gonzalez'
--10.	List the invoice number and invoice date for each invoice that contains an invoice line for Wild Bird Food (25 lb).
SELECT * FROM INVOICES, INVOICE_LINE, ITEM WHERE INVOICES.INVOICE_NUM = INVOICE_LINE.INVOICE_NUM AND INVOICE_LINE.ITEM_ID = ITEM.ITEM_ID AND ITEM.DESCRIPTION LIKE('%Wild Bird Food%')
--11.	List the invoice number and invoice date for each invoice that either was created for James Gonzalez or that contains an invoice line for Wild Bird Food (25 lb).
SELECT INVOICES.INVOICE_NUM, INVOICES.INVOICE_DATE 
FROM INVOICES, INVOICE_LINE, CUSTOMER, ITEM 
WHERE INVOICES.INVOICE_NUM = INVOICE_LINE.INVOICE_NUM AND INVOICES.CUST_ID = CUSTOMER.CUST_ID AND INVOICE_LINE.ITEM_ID = ITEM.ITEM_ID AND (CUSTOMER.FIRST_NAME = 'James' AND CUSTOMER.LAST_NAME = 'Gonzalez' OR ITEM.DESCRIPTION LIKE('%Wild Bird Food%'))
--12.	List the invoice number and invoice date for each invoice that was created for James Gonzalez and that contains an invoice line for Wild Bird Food (25 lb).
SELECT INVOICES.INVOICE_NUM, INVOICES.INVOICE_DATE FROM INVOICES, INVOICE_LINE, CUSTOMER, ITEM WHERE INVOICES.INVOICE_NUM = INVOICE_LINE.INVOICE_NUM AND INVOICES.CUST_ID = CUSTOMER.CUST_ID AND INVOICE_LINE.ITEM_ID = ITEM.ITEM_ID AND CUSTOMER.FIRST_NAME = 'James' AND CUSTOMER.LAST_NAME = 'Gonzalez' AND ITEM.DESCRIPTION LIKE('%Wild Bird Food%')
--13.	List the item ID, description, unit price, and category for each item that has a unit price greater than the unit price of every item in category CAT. Use either the ALL or ANY operator in your query. 
SELECT ITEM_ID, DESCRIPTION, PRICE, CATEGORY FROM ITEM WHERE ITEM.PRICE > ALL (SELECT ITEM.PRICE FROM ITEM WHERE ITEM.CATEGORY = 'CAT')
  