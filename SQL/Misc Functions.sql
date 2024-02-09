--Aggregates

--Max
Select max(Balance) from Customer
--Min
Select min(Balance) from Customer
--Sum
Select sum(Balance) from CUSTOMER
--Avg
Select avg(Balance) from Customer

--Conversion
--Cast
Select Cast(Balance as int) from Customer --Be Careful casting numbers, you may get unexpected results
Select Cast(Month(Invoice_Date) as varchar(2)) from Invoices

Select Concat_WS('/',Cast(Month(Invoice_Date) as varchar(2)),Cast(DAY(Invoice_Date) as varchar(2)),Cast(Year(Invoice_Date) as varchar(4))) from Invoices

--Round
Select Balance from Customer
Select Round(Balance,1) from CUSTOMER

--Floor
Select Balance from Customer
Select FLOOR(Balance) from CUSTOMER

--Ceiling
Select Balance from Customer
Select Ceiling(Balance) from CUSTOMER