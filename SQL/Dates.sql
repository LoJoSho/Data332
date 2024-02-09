USE [KimTay]
GO

--Important Note - Dates, by default, are in UTC
--GetDate() - Returns Current Date and Time
Select GetDate() at time zone 'Central Standard Time'

--DatePart
Select DATEPART(WEEKDAY,GETDATE())--Day of the week (Sunday=1)
Select DATEPART(DAY,GETDATE())--Numeric Day of month
Select DATEPART(MONTH,GETDATE())--Numeric Month
Select DATEPART(YEAR,GETDATE())
--Shorthand
Select MONTH(getdate())
Select DAY(getdate())
Select YEAR(GETDATE())

Select Year(Invoice_Date) from INVOICES
Select Day(Invoice_Date) from INVOICES
Select Month(Invoice_Date) from INVOICES

--EXERCISE - Display a Count of Invoices by Year and Month









Select Year(Invoice_Date) as InvoiceYear,Month(Invoice_date) as InvoiceMonth, Count(Invoice_Num) as Invoices
From INVOICES
Group By Year(Invoice_Date), Month(Invoice_date)
order by Year(Invoice_Date) , Month(Invoice_date) 

--For Time too
Select DATEPART(HOUR,getdate())
Select DATEPART(MINUTE,getdate())
Select DATEPART(SECOND,getdate())

--DateAdd - Add an Interval to a Date
Select DATEADD(DAY,7,getdate()) --Add 7 days
Select DATEADD(MONTH,6,getdate()) --Add 6 months
Select DATEADD(DAY,-7,getdate()) --Get date 7 days prior

--Adding Days quickly
Select Getdate() + 7 as nextweek

--DateDiff
--Calculting the Differences between two dates
Declare @Tomorrow smalldatetime = '2023-11-27 00:00:00'
Select DATEDIFF(HOUR,getdate(),@Tomorrow)

