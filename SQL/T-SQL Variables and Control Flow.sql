--Variables
--Declaring a variable:

Declare @var1 as varchar(30)
Declare @var2 as varchar(10), @var3 as int, @var4 as decimal(7,2)
Declare @var5 as int = 0 --Define a default value in the declare

--Setting a value 
Set @var1 = 'test'
Set @var2 = 'test'
Set @var3 = 5
Set @var4=1.0

--Use Select or print to see your variable value
Declare @myvar int = 10
Select @myvar
print @myvar --Shows in your messages window

--Setting a value by selecting from a table
Declare @maxcredit decimal(7,2)
Select @maxcredit = MAX(Credit_Limit) from CUSTOMER
Select @maxcredit
SELECT * FROM CUSTOMER WHERE CREDIT_LIMIT > @maxcredit

--EXERCISE
--Create a variable to hold the e-mail address of the customer with the highest credit limit, and write a command to assign it

Declare @email varchar(30)
Select TOP 1 @email = EMAIL from Customer where CREDIT_LIMIT = (Select MAX(CREDIT_LIMIT) from Customer)
order by email asc
Select @email

--Control of Flow - If..Then and Begin..End

Declare @b1 varchar(5) = 'test1', @b2 varchar(5) = 'test1'
--If you only have a single statement to execute, Begin..End is not necessary
if (@b1=@b2)
	print 'true'
else
	print 'false'

--Use Begin..End to enclose groups of statements
set @b2 = 'test2'
-- Exists(Select * FROM CUSTOMER WHERE email='@b2'
if (@b1=@b2)
	Begin
		print 'true'
		select Max(Balance) from Customer
	End
Else
	Begin
		print 'false'
		select Min(Balance) from customer
	End

--Using If Then Else 
Declare @i1 as int = 5, @i2 as int = 6

if (@i1 = @i2) 
	Begin
		Print 'equal'
	End
Else if (@i1 > @i2) --This is false, so it falls to the last Else
	Begin
		Print 'one is greater than two'
	End
Else
	Begin
		Print 'two is greater than one'
	End

--Using other logical operators - if you can test for it in a where clause, you should be able to use it in an if statement

--IN
Declare @e varchar(30) = 'mattpelham@augustana.edu'
if (@e is not null and @e IN (Select email from CUSTOMER))
	Begin
		Print 'Found it'
	End
Else
	Begin
		Print 'Not Found'
	End

--EXISTS
Declare @state varchar(15) = 'WY'

If Exists (Select CUST_ID from Customer where State=@state)
	select * from Customer where State = @State
Else
	Return --Return statement ends execution


--EXERCISE
--Write a statement to check and see if there are any customer that have a balance greater than their credit limit.  If there is, print the customer name and how much 
--the customer has exceeded his/her credit limit

if Exists(Select * from Customer where Balance > CREDIT_LIMIT)
	Select First_Name, Last_Name, Balance - Credit_Limit as 'Amount Over' from Customer where Balance > Credit_Limit