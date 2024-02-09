-- Benefits:
-- "Data Independence" Provide a layer of abstraction over fixed, physical tables
-- 

-- Basic View 
CREATE VIEW DOGS as
(
Select ITEM_ID, DESCRIPTION, ON_HAND, PRICE
FROM ITEM WHERE CATEGORY = 'Dog'
)

Select * FROM DOGS

-- Custom Column Names for Views
CREATE VIEW DGS (ID, DSC, OH, PRCE) as 
(
Select ITEM_ID, DESCRIPTION, ON_HAND, PRICE
FROM ITEM
WHERE CATEGORY = 'DOG'
)

Select * From DGS

-- REP_CUST View
CREATE VIEW REP_CUST (RID, RFIRST, RLAST, CID, CFIRST, CLAST) AS 
(
SELECT SALES_REP.REP_ID, SALES_REP.FIRST_NAME, SALES_REP.LAST_NAME,
CUSTOMER.CUST_ID, CUSTOMER.FIRST_NAME, CUSTOMER.LAST_NAME
from SALES_REP, CUSTOMER
WHERE SALES_REP.REP_ID = CUSTOMER.REP_ID
)

-- CRED_CUST View
CREATE VIEW CRED_CUST(CREDIT_LIMIT, NUM_CUSTOMERS) as 
(
SELECT CREDIT_LIMIT, Count(*)
from CUSTOMER
GROUP By CREDIT_LIMIT
)

-- Indexes
-- "Tells SQL Server a better way to look up data" / Performance Tuning
CREATE INDEX BALINDEX ON CUSTOMER(BALANCE)

Select CUST_ID from CUSTOMER where Balance > 50

Create Index REP_NAME on SALES_REP(LAST_NAME, FIRST_NAME)

SELECT Last_Name, First_Name from SALES_REP where LAST_NAME = 'Miller'

-- Unique Index
CREATE UNIQUE INDEX DESC_INDES ON ITEM(DESCRIPTION)


-- Integrity Constraints
-- Constraints to ensure data is correct

-- Adding foreign Key
ALTER TABLE INVOICES
ADD CONSTRAINT FK_CUSTID 
FOREIGN KEY (CUST_ID) REFERENCES CUSTOMER(CUST_ID)

-- Adding Integrity Check
Alter Table Item
Add Constraint Check_Category Check (Category in ('BRD', 'CAT', 'DOG', 'FSH', 'HOR'))

update item set cateogry = 'xyz' where ITEM_ID = 'LP73'

